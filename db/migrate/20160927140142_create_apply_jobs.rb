class CreateApplyJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :apply_jobs do |t|
      t.references :user, foreign_key: true, index: true
      t.references :job_post, foreign_key: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
