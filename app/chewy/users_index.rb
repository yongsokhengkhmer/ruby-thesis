class UsersIndex < Chewy::Index
  include SettingAnalysis
  attr_accessor :bool_query

  define_type User do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, analyzer: "custom_analyzer", value: -> {name}
    field :address, value: -> {address}
    field :job_type, value: ->(user) {user.job_types.pluck(:id).join(" ")}
  end

  class << self
    def search_user params
      bool = {
        should: []
      }

      bool[:should] << {match_phrase: {name: params[:name]}} if params[:name].present?
      bool[:should] << {match: {job_type: params[:job_type]}} if params[:job_type].present?
      bool[:should] << {match: {address: params[:address]}} if params[:address].present?

      query bool: bool
    end
  end
end
