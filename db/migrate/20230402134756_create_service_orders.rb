class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.integer :quantity, null: false
      t.references :order, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
