namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke
    Chewy.strategy(:atomic) do
      puts "Create job types ..."
      ["Information Technology", "Designer", "Customer Service", "Accounting", "Banking",
        "Civil Engineer", "Marketing", "Lecturer", "Finance", "Audit", "Saler"].each do |type|
        JobType.create name: type
      end

      puts "Create admin ..."
      admin = User.create name: "Admin", email: "admin@gmail.com", password: "12345678",
        password_confirmation: "12345678", phone_number: "0929384854", role: User.roles[:admin]

      puts "Create recruiters"
      # Vietnam
      framgia = User.create name: "Framgia", email: "framgia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 4]

      vtc = User.create name: "VTC", email: "vtc@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 3]

      fpt = User.create name: "fpt", email: "fpt@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 7]

      sony = User.create name: "sony", email: "sony@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 11]

      line = User.create name: "Line", email: "line@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [2, 4, 11]

      vietcobank = User.create name: "vietcombank", email: "vietcombank@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 5]

      vib = User.create name: "VIB Bank", email: "vib@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      accounting_company = User.create name: "Accounting Company", email: "accounting_company@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      kpmg = User.create name: "KPMG", email: "kpmg@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [5, 9, 10]


      viet_name_airline = User.create name: "Vietnam Airline", email: "viet_name_airline@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 11]

      # cambodia
      blue_technoloy = User.create name: "Blue Technology", email: "blue_technoloy@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 4]

      web_essential = User.create name: "Web Essential", email: "web_essential@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 3]

      digi = User.create name: "Digi", email: "digi@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 7]

      sony_cambodia = User.create name: "sony cambodia", email: "sony_cambodia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 11]

      cellcard = User.create name: "cellcard", email: "cellcard@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [2, 4, 11]

      aceleda = User.create name: "aceledabank", email: "aceleda@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 5]

      prasak = User.create name: "prasak Bank", email: "prasak@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      accounting_cambodia = User.create name: "Accounting Cambodia", email: "accounting_cambodia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      kpmg_cambodia = User.create name: "KPMG Cambodia", email: "kpmg_cambodia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [5, 9, 10]

      angkor_airline = User.create name: "Angkor Airline", email: "angkor_airline@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "cambodia", phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 11]

      puts "Create applicants"
      applicant1 = User.create name: "Vuthy", email: "vuthy@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 300, job_type_ids: [2, 3]

      applicant2 = User.create name: "Daro", email: "daro@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 400, job_type_ids: [5, 6, 8]

      applicant3 = User.create name: "Kim", email: "kim@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 350, job_type_ids: [4, 5, 9]

      applicant4 = User.create name: "Duc", email: "duc@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 500, job_type_ids: [7]

      applicant5 = User.create name: "Viet", email: "viet@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 450, job_type_ids: [1, 2]

      applicant6 = User.create name: "Hoang", email: "hoang@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 9]
    end

    applicant7 = User.create name: "Hoa", email: "hoa@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant]
    [2, 9].each do |job_type|
      applicant7.user_job_types.create job_type_id: job_type
    end

    applicant8 = User.create name: "Le Thanh Tung", email: "lethanhtung@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Vietnam", phone_number: "0929384854", role: User.roles[:applicant]
    [1, 4, 9].each do |job_type|
      applicant8.user_job_types.create job_type_id: job_type
    end

    applicant9 = User.create name: "Le Thi Chuyen", email: "lethichuyen@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Thailand", phone_number: "0929384854", role: User.roles[:applicant]
    [3, 5, 8].each do |job_type|
      applicant9.user_job_types.create job_type_id: job_type
    end

    applicant10 = User.create name: "Thanh Hung", email: "thanhhung@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Thailand", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 6].each do |job_type|
      applicant10.user_job_types.create job_type_id: job_type
    end

    applicant11 = User.create name: "Trang", email: "trang@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "Thailand", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 6].each do |job_type|
      applicant11.user_job_types.create job_type_id: job_type
    end

    applicant12 = User.create name: "Ngoc", email: "ngoc@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "USA", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 7].each do |job_type|
      applicant12.user_job_types.create job_type_id: job_type
    end

    applicant13 = User.create name: "Giang", email: "giang@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "USA", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 6].each do |job_type|
      applicant13.user_job_types.create job_type_id: job_type
    end

    applicant14 = User.create name: "Ngoc Cuong", email: "ngoccuong@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "USA", phone_number: "0929384854", role: User.roles[:applicant]
    [3, 5].each do |job_type|
      applicant14.user_job_types.create job_type_id: job_type
    end

    applicant15 = User.create name: "Huong", email: "huong@gmail.com",
      password: "12345678", password_confirmation: "12345678",
      address: "USA", phone_number: "0929384854", role: User.roles[:applicant]
    [5, 6].each do |job_type|
      applicant15.user_job_types.create job_type_id: job_type
    end
  end
end
