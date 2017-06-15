class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :street_address_1, :street_address_2, :city, :state, :zip
      t.string :phone_number
      t.timestamps
    end
  end
end
