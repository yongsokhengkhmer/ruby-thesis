class JobsIndex < Chewy::Index
  define_type JobPost.includes(:job_types) do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, value: -> {name}
    field :location, value: -> {location}
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
          {match: {location: applicant.address}}
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
  end
end

