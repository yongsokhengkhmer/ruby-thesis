class CreateDegrees < ActiveRecord::Migration[5.0]
  def change
    create_table :degrees do |t|
      t.string :name
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
