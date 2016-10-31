class CreateJobPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :job_posts do |t|
      t.string :name
      t.string :location
      t.float :min_salary
      t.float :max_salary
      t.boolean :negotiable, default: false
      t.references :post, foreign_key: true, index: true

      t.timestamps
    end
  end
end
