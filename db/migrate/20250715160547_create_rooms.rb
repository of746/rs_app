class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :facility_name
      t.string :facility_Introduction
      t.integer :fee
      t.string :address

      t.timestamps
    end
  end
end
