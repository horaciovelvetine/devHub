class CreateCronfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :cronfigs do |t|
      t.integer :days, default: 0
      t.integer :hours, default: 0
      t.integer :minutes, default: 15
      t.integer :seconds, default: 0
      t.boolean :run_on_start, default: true
      t.belongs_to :bot, null: false, foreign_key: true

      t.timestamps
    end
  end
end