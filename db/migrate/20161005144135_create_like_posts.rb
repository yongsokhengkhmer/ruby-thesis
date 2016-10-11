class CreateLikePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :like_posts do |t|
      t.references :activity, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
