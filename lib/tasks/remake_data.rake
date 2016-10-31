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
    ["Information Technology", "Accounting", "Banking", "Civil Engineer",
      "Marketing", "Lecturer"].each do |type|
      JobType.create name: type
    end
  end
end
