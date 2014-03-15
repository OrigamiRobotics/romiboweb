class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user, index: true
      t.string :name
      t.string :nickname
      t.text :token
      t.string :email
      t.string :image_url

      t.timestamps
    end
  end
end
