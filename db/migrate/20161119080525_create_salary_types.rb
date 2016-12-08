class CreateSalaryTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :salary_types do |t|
      t.string :name
      t.float :min_salary
      t.float :max_salary
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
