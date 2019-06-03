class RenameFeedbackColumns < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :feedbacks do |f|
        dir.up do
          f.rename :name, :user_name
          f.rename :email, :user_email
          f.rename :title, :statement
          f.rename :content, :description
        end
        dir.down do
          f.rename :user_name, :name
          f.rename :user_email, :email
          f.rename :statement, :title
          f.rename :description, :content
        end
      end
    end
  end
end
