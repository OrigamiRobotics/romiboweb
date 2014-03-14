class AddNameAndEmailToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :name, :string
    add_column :feedbacks, :email, :string
  end
end
