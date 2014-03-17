class RenameFeedbackColumns < ActiveRecord::Migration
  def change
    change_table :feedbacks do |f|
      f.rename :name, :user_name
      f.rename :email, :user_email
      f.rename :title, :statement
      f.rename :content, :description
    end
  end
end
