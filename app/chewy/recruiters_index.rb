class RecruitersIndex < Chewy::Index
  define_type User.recruiter.includes(:job_types) do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, value: -> {name}
    field :email, value: -> {email}
    field :country, value: -> {country.name}
    field :job_types, value: -> {job_types.pluck :name}
  end

  class << self
    def suggest_to_applicant applicant
      query(bool: {
        must_not: {terms: {id: applicant.followeds.pluck(:followed_id)}},
        should: [
          {match: {country: applicant.country_name}},
          {match: {
            job_types: {
              query: applicant.job_types.pluck(:name).join(" "),
              boost: 2
            }
          }}
        ]
      })
    end

    def suggest_to_recruiter recruiter
      query(bool: {
        must_not: [
          {match: {id: recruiter.id}},
          {terms: {id: recruiter.followeds.pluck(:followed_id)}}
        ],
        should: [
          {match: {
            country: {
              query: recruiter.country_name,
              boost: 2
            }
          }},
          {match: {job_types: recruiter.job_types.pluck(:name).join(" ")}}
        ]
      })
    end
  end
end
