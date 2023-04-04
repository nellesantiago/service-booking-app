class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.date :date, null: false
      t.references :time_slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
