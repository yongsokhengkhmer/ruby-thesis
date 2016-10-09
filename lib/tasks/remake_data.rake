namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Create users ..."
    admin = User.create name: "Admin", email: "admin@gmail.com", password: "12345678",
      password_confirmation: "12345678", phone_number: "0929384854", role: User.roles[:admin]
    recruiter = User.create name: "Recruiter", email: "recruiter@gmail.com", password: "12345678",
      password_confirmation: "12345678", phone_number: "0929384854", role: User.roles[:recruiter]
    applicant = User.create name: "Applicant", email: "applicant@gmail.com", password: "12345678",
      password_confirmation: "12345678", phone_number: "0929384854",
      role: User.roles[:applicant]
    applicant.create_user_profile gender: UserProfile.genders[:male], birth_date: "1990/01/01"

    puts "Create job types ..."
    JobType.create name: "Information Technology"
    JobType.create name: "Accounting"
    JobType.create name: "Banking"
    JobType.create name: "Civil Engineer"
    JobType.create name: "Marketing"
    JobType.create name: "Lecturer"

    puts "Create job posts ..."
    10.times do
      post = recruiter.posts.create content: Faker::Lorem.paragraph, status: Post.statuses[:public_post]
      post.create_job_post name: Faker::Commerce.department, location: Faker::Address.city,
        job_type: JobType.all.sample
      post.create_activity user_id: recruiter.id
    end

    puts "Create posts ..."
    10.times do
      post = applicant.posts.create content: Faker::Lorem.paragraph, status: Post.statuses[:public_post]
      post.create_activity user_id: applicant.id
    end
  end
end
