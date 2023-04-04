class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.text :details, null: false
      t.integer :price, null: false
      t.integer :service_type, default: 0
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
