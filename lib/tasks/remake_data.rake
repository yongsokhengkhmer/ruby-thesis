namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Create job types ..."
    ["Information Technology", "Accounting", "Banking", "Civil Engineer",
      "Marketing", "Lecturer", "Finance", "Audit", "Saler"].each do |type|
      JobType.create name: type
    end

    puts "Create admin ..."
    admin = User.create name: "Admin", email: "admin@gmail.com", password: "12345678",
      password_confirmation: "12345678", phone_number: "0929384854", role: User.roles[:admin]

    puts "Create recruiters"

    recruiter1 = User.create name: "Framgia", email: "framgia@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter]
    [1, 2, 3].each do |job_type|
      recruiter1.user_job_types.create job_type_id: job_type
    end

    recruiter2 = User.create name: "VTC", email: "vtc@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter]
    [3, 4, 5].each do |job_type|
      recruiter2.user_job_types.create job_type_id: job_type
    end

    recruiter3 = User.create name: "Aceleda Bank", email: "acleda@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter]
    [5, 6, 8].each do |job_type|
      recruiter3.user_job_types.create job_type_id: job_type
    end

    recruiter4 = User.create name: "ANZ", email: "delta@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter]
    [5, 6, 8].each do |job_type|
      recruiter4.user_job_types.create job_type_id: job_type
    end


    puts "Create applicants"
    applicant1 = User.create name: "Vuthy", email: "vuthy@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Cambodia", phone_number: "0929384854", role: User.roles[:applicant]
    [2, 3].each do |job_type|
      applicant1.user_job_types.create job_type_id: job_type
    end

    applicant2 = User.create name: "Daro", email: "daro@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Cambodia", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 6, 8].each do |job_type|
      applicant2.user_job_types.create job_type_id: job_type
    end

    applicant3 = User.create name: "Kim", email: "kim@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Cambodia", phone_number: "0929384854", role: User.roles[:applicant]
    [2, 3, 4].each do |job_type|
      applicant3.user_job_types.create job_type_id: job_type
    end

    applicant4 = User.create name: "Duc", email: "duc@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant]
    [7].each do |job_type|
      applicant4.user_job_types.create job_type_id: job_type
    end

    applicant5 = User.create name: "Viet", email: "viet@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant]
    [1, 4].each do |job_type|
      applicant5.user_job_types.create job_type_id: job_type
    end

    applicant6 = User.create name: "Hoang", email: "hoang@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 9].each do |job_type|
      applicant6.user_job_types.create job_type_id: job_type
    end
  end
end
