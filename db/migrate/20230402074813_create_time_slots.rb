class CreateTimeSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :time_slots do |t|
      t.string :time, null: false
      t.integer :max_slot, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
