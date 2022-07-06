class CreateBots < ActiveRecord::Migration[7.0]
  def change
    create_table :bots do |t|
      t.string :name, default: 'Quebert'
      t.datetime :last_qrtine
      t.integer :total_posts, default: 0
      t.integer :total_clicks, default: 0

      t.timestamps
    end
  end
end
