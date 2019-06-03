class AddEncryptionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :encryption, :string, index: true
    add_column :users, :encryption_key, :string, index: true
    add_column :users, :encryption_iv, :string, index: true
  end
end
