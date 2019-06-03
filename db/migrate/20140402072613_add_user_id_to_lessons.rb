class AddUserIdToLessons < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :lessons, :user
  end
end
