class CreateSavePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :save_posts do |t|
      t.references :user, foreign_key: true, index: true
      t.references :activity, foreign_key: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
    add_index :save_posts, [:user_id, :activity_id], unique: true
  end
end
