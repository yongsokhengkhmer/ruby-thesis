class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :conversation, foreign_key: true, index: true
      t.integer :sender_id, index: true
      t.integer :receiver_id, index: true
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
