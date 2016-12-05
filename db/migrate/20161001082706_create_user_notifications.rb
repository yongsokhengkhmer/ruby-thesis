class CreateUserNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :user_notifications do |t|
      t.references :notification, foreign_key: true, index: true
      t.integer :sender_id, index: true
      t.integer :receiver_id, index: true
      t.integer :status, default: 0
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
