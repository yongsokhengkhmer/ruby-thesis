class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.integer :gender
      t.date :birth_date
      t.string :current_position
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
