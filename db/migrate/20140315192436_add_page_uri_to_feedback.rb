class AddPageUriToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :page_uri, :string
  end
end
