class CreateUserJobTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_job_types do |t|
      t.references :user, foreign_key: true, index: true
      t.references :job_type, foreign_key: true, index: true

      t.timestamps
    end
  end
end
