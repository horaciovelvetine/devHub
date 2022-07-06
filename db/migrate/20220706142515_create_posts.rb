class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      # #where target is == guild.id on discord.js
      t.string :target, null: false
      t.string :body, null: false
      t.boolean :queued, default: true
      t.integer :clicks, default: 0
      t.integer :responses, default: 0
      t.belongs_to :bot, null: false, foreign_key: true

      t.timestamps
    end
  end
end