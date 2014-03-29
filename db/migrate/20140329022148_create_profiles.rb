class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :user_name
      t.belongs_to :user, index: true
      t.string :avatar
      t.string :slug

      t.timestamps
    end
    add_index :profiles, :slug, unique: true
  end
end
