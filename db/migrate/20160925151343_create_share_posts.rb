class CreateSharePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :share_posts do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :status
      t.timestamps
    end
  end
end
