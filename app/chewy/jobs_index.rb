class JobsIndex < Chewy::Index
  define_type JobPost.includes(:job_types) do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, value: -> {name}
    field :country, value: -> {country.name}
    field :job_types, value: -> {job_types.pluck :name}
    field :negotiable, type: "boolean", value: -> {negotiable}
    field :min_salary, type: "float", value: -> {min_salary}
    field :max_salary, type: "float", value: -> {max_salary}
  end

  class << self
    def suggest_to_applicant applicant
      query(bool: {
        must: [
          {match: {job_types: applicant.job_types.pluck(:name).join(" ")}},
          {match: {country: applicant.country_name}}
        ],
        should: [
          {bool: {
            must: [
              {range: {min_salary: {lte: applicant.expected_salary}}},
              {range: {max_salary: {gte: applicant.expected_salary}}}
            ]
          }},
          {bool: {
            must: [
              {range: {min_salary: {lte: applicant.expected_salary}}},
              constant_score: {filter: {missing: {field: "max_salary"}}}
            ]
          }},
          {bool: {
            must: [
              {range: {max_salary: {gte: applicant.expected_salary}}},
              constant_score: {filter: {missing: {field: "min_salary"}}}
            ]
          }},
          {term: {negotiable: true}},
        ],
        minimum_should_match: 1
      })
    end

    def search_jobs name, job_types, country, salary_type_id, current_user
      bool = {
        must: [],
        should: []
      }

      bool[:must] << {query_string: {query: "name:*#{name}*"}} if name.present?

      if job_types.present?
        bool[:must] << {match: {job_types: job_types}}
      else
        bool[:should] << {match: {job_types: current_user.job_types.pluck(:name).join(" ")}}
      end

      if country.present?
        country_data = Country.find country
        bool[:must] << {match: {country: country_data.name}}
      else
        bool[:should] << {match: {country: current_user.country_name}}
      end

      if salary_type_id.present?
        salary_type = SalaryType.find salary_type_id
        if salary_type.min_salary.present? && salary_type.max_salary.present?
          bool[:must] << range_search(salary_type.min_salary, salary_type.max_salary)
        elsif salary_type.min_salary.present?
          bool[:must] << range_salary_from(salary_type.min_salary)
        else
          bool[:must] << range_salary_max(salary_type.max_salary)
        end
      end

      query bool: bool

    end

    def range_search min_salary, max_salary
      {bool: {
        should: [
          {bool: {
            must: [
              {range: {min_salary: {lte: max_salary}}},
              {range: {max_salary: {gte: min_salary}}}
            ]
          }},
          {bool: {
            must: [
              {range: {min_salary: {lte: max_salary}}},
              constant_score: {filter: {missing: {field: "max_salary"}}}
            ]
          }},
          {bool: {
            must: [
              {range: {max_salary: {gte: min_salary}}},
              constant_score: {filter: {missing: {field: "min_salary"}}}
            ]
          }},
          {term: {negotiable: true}},
        ],
        minimum_should_match: 1
      }}
    end

    def range_salary_max max_salary
      {bool: {
        should: [
          {bool: {
            must: [
              {range: {min_salary: {lte: max_salary}}}
            ]
          }},
          {bool: {
            must: [
              constant_score: {filter: {missing: {field: "min_salary"}}}
            ]
          }},
          {term: {negotiable: true}}
        ],
        minimum_should_match: 1
      }}
    end

    def range_salary_from min_salary
      {bool: {
        should: [
          {bool: {
            must: [
              {range: {max_salary: {gte: min_salary}}}
            ]
          }},
          {bool: {
            must: [
              constant_score: {filter: {missing: {field: "max_salary"}}}
            ]
          }},
          {term: {negotiable: true}}
        ],
        minimum_should_match: 1
      }}
    end
  end
end

