class CreateMarkInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :mark_interests do |t|
      t.integer :marker_id
      t.integer :marked_id

      t.timestamps
    end
    add_index :mark_interests, [:marker_id, :marked_id], unique: true
  end
end
