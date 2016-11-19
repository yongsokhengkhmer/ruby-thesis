class UsersIndex < Chewy::Index
  attr_accessor :bool_query

  define_type User do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, value: -> {name}
    field :address, value: -> {address}
    field :job_type, value: ->(user) {user.job_types.pluck(:name).join(" ")}
  end

  class << self
    def search_user name, job_type, location, current_user
      bool = {
        must: [],
        should: []
      }

      bool[:must] << {query_string: {query: "name:*#{name}*"}} if name.present?

      if job_type.present?
        bool[:must] << {match: {job_type: job_type}}
      else
        bool[:should] << {match: {job_type: current_user.job_types.pluck(:name).join(" ")}}
      end

      if location.present?
        bool[:must] << {match: {address: location}}
      else
        bool[:should] << {match: {address: current_user.address}}
      end

      query bool: bool
    end
  end
end
