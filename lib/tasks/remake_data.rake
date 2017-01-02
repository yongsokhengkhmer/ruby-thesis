namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke
    Rake::Task["chewy:reset"].invoke

    Chewy.strategy(:atomic) do
      puts "Create countries ..."
      ["Cambodia", "Vietnam"].each do |name|
        Country.create name: name
      end

      puts "Create job types ..."
      ["Information Technology", "Designer", "Customer Service", "Accounting", "Banking",
        "Civil Engineer", "Marketing", "Lecturer", "Finance", "Audit", "Saler", "Programmer",
        "Architecture", "Electrical Engineer"].each do |type|
        JobType.create name: type
      end

      puts "Create admin ..."
      User.create name: "Admin", email: "admin@gmail.com", password: "12345678",
        password_confirmation: "12345678", phone_number: "0929384854", role: User.roles[:admin],
        country_id: 1

      puts "Create recruiters"
      # Vietnam
      User.create name: "Framgia", email: "framgia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 4]

      User.create name: "VTC", email: "vtc@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 3]

      User.create name: "fpt", email: "fpt@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 7]

      User.create name: "sony", email: "sony@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 11]

      User.create name: "Line", email: "line@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [2, 4, 11]

      User.create name: "vietcombank", email: "vietcombank@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 5]

      User.create name: "VIB Bank", email: "vib@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      User.create name: "Accounting Company", email: "accounting_company@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      User.create name: "KPMG", email: "kpmg@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [5, 9, 10]


      User.create name: "Vietnam Airline", email: "viet_name_airline@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 11]

      User.create name: "BKAV", email: "bkav@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 12, 14]

      User.create name: "BKAV", email: "trueplus@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [2, 1, 12]

      # cambodia
      User.create name: "Blue Technology", email: "blue_technoloy@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 4]

      User.create name: "Web Essential", email: "web_essential@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 3]

      User.create name: "Digi", email: "digi@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 2, 7]

      User.create name: "sony cambodia", email: "sony_cambodia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [1, 11, 12]

      User.create name: "cellcard", email: "cellcard@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [2, 4, 11]

      User.create name: "aceledabank", email: "aceleda@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 5]

      User.create name: "prasak Bank", email: "prasak@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      User.create name: "Accounting Cambodia", email: "accounting_cambodia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 9]

      User.create name: "KPMG Cambodia", email: "kpmg_cambodia@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [5, 9, 10]

      User.create name: "Angkor Airline", email: "angkor_airline@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [3, 4, 11]

      User.create name: "Samsung Cambodia", email: "samsungkh@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:recruiter],
        job_type_ids: [2, 14, 12]

      puts "Create applicants"
      User.create name: "Vuthy", email: "vuthy@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 300, job_type_ids: [2, 3]

      User.create name: "Daro", email: "daro@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 400, job_type_ids: [5, 6, 8]

      User.create name: "Kim", email: "kim@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 350, job_type_ids: [4, 5, 9]

      User.create name: "Seyha", email: "seyha@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 400, job_type_ids: [2, 14]

      User.create name: "Sokha", email: "sokha@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 300, job_type_ids: [4, 5, 9]

      User.create name: "Theary", email: "theary@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 500, job_type_ids: [2, 6, 13]

      User.create name: "Kimheng", email: "kimheng@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 500, job_type_ids: [4, 9, 5]

      User.create name: "Srey Leap", email: "sreyleap@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Cambodia", country_id: 1, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 450, job_type_ids: [2, 6, 13]

      #vietnam
      User.create name: "Minh", email: "minh@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 400, job_type_ids: [2, 14]

      User.create name: "Thong", email: "thong@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Viet", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 300, job_type_ids: [4, 5, 9]

      User.create name: "Ngoc", email: "ngoc@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 500, job_type_ids: [2, 6, 13]

      User.create name: "Phuong", email: "phuong@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 500, job_type_ids: [4, 9, 5]

      User.create name: "Duy khanh", email: "duykhanh@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 450, job_type_ids: [2, 6, 13]

      User.create name: "Duc", email: "duc@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 500, job_type_ids: [7]

      User.create name: "Viet", email: "viet@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 450, job_type_ids: [1, 2]

      User.create name: "Hoang", email: "hoang@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 9]

      User.create name: "Hoa", email: "hoa@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [2, 9]

      User.create name: "Le Thanh Tung", email: "lethanhtung@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [1, 4, 9]

      User.create name: "Le Thi Chuyen", email: "lethichuyen@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [3, 5, 9]

      User.create name: "Thanh Hung", email: "thanhhung@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 6]

      User.create name: "Trang", email: "trang@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 6]

      User.create name: "Ngoc", email: "ngoc@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 7]

      User.create name: "Giang", email: "giang@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 6]

      User.create name: "Ngoc Cuong", email: "ngoccuong@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [3, 5]

      User.create name: "Huong", email: "huong@gmail.com",
        password: "12345678", password_confirmation: "12345678",
        address: "Vietnam", country_id: 2, phone_number: "0929384854", role: User.roles[:applicant],
        expected_salary: 600, job_type_ids: [5, 6]

      SalaryType.create name: "< 500", max_salary: 500
      SalaryType.create name: "500 - 1000", min_salary: 500, max_salary: 1000
      SalaryType.create name: "1000 - 1500", min_salary: 1000, max_salary: 1500
      SalaryType.create name: "1500 - 2000", min_salary: 1500, max_salary: 2000
      SalaryType.create name: "2000 - 3000", min_salary: 2000, max_salary: 3000
      SalaryType.create name: "> 3000", min_salary: 3000
    end
  end
end
