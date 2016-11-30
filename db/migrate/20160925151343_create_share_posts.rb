class CreateSharePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :share_posts do |t|
      t.string :content
      t.references :user, foreign_key: true, index: true
      t.references :post, foreign_key: true, index: true
      t.timestamps
    end
  end
end
