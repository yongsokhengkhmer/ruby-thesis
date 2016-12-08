class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :subject
      t.text :content
      t.references :user, foreign_key: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
