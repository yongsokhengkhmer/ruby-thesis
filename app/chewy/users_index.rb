class UsersIndex < Chewy::Index
  attr_accessor :bool_query

  define_type User do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, value: -> {name}
    field :country, value: -> {country_name}
    field :job_type, value: ->(user) {user.job_types.pluck(:name).join(" ")}
  end

  class << self
    def search_user name, job_type, country, current_user
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

      if country.present?
        country_data = Country.find country
        bool[:must] << {match: {country: country_data.name}}
      else
        bool[:should] << {match: {country: current_user.country_name}}
      end

      query bool: bool
    end
  end
end
