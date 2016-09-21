class CreateEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :educations do |t|
      t.string :school
      t.date :start_date
      t.date :end_date
      t.references :degree, foreign_key: true
      t.string :field_of_study
      t.string :grade
      t.string :social_activies
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
