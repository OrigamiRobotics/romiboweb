class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.string :title, null: false
      t.string :color
      t.string :speech_phrase
      t.float :speech_speed_rate
      t.belongs_to :user
      t.timestamps
    end

    add_index :buttons, :user_id
  end
end
