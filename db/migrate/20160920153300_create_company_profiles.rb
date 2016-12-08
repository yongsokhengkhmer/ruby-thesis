class CreateCompanyProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :company_profiles do |t|
      t.date :start_up_date
      t.string :website
      t.text :description
      t.references :user, foreign_key: true, index: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
