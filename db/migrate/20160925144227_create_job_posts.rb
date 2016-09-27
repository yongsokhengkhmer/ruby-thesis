class CreateJobPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :job_posts do |t|
      t.string :name
      t.string :location
      t.references :job_type, foreign_key: true, index: true
      t.references :post, foreign_key: true, index: true

      t.timestamps
    end
  end
end
