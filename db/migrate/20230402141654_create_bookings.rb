class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :mobile_number, null: false
      t.string :street, null: false
      t.string :barangay, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.integer :postal_code, null: false
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
