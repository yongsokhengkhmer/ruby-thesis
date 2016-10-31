class RecruitersIndex < Chewy::Index
  define_type User.recruiter.includes(:job_types) do
    witchcraft!
    field :id, type: "integer", value: -> {id}
    field :name, value: -> {name}
    field :email, value: -> {email}
    field :address, value: -> {address}
    field :job_types, value: -> {job_types.pluck :name}
  end

  class << self
    def suggest_to_applicant applicant
      query(bool: {
        must_not: {terms: {id: applicant.followeds.pluck(:followed_id)}},
        should: [
          {match: {address: applicant.address}},
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
            address: {
              query: recruiter.address,
              boost: 2
            }
          }},
          {match: {job_types: recruiter.job_types.pluck(:name).join(" ")}}
        ]
      })
    end
  end
end
