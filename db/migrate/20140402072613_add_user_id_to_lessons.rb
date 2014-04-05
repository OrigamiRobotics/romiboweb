class AddUserIdToLessons < ActiveRecord::Migration
  def change
    add_belongs_to :lessons, :user
  end
end
