class CreateClinics < ActiveRecord::Migration[6.1]
  def change
    create_table :clinics do |t|
      t.string :facility
      t.string :phone_number
      t.string :city
      t.integer :zip_code

      t.timestamps
    end
  end
end
