class CreateUserNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :user_notifications do |t|
      t.references :notification, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
