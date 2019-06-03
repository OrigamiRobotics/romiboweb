class AddPageUriToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :page_uri, :string
  end
end
