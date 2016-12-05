class CreateJobPostTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :job_post_types do |t|
      t.references :job_post, foreign_key: true, index: true
      t.references :job_type, foreign_key: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
