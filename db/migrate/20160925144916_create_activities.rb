class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :trackable_id
      t.string :trackable_type
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
