class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.string :current_position
      t.date :birth_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
