class Feedback < ActiveRecord::Base
  belongs_to :user, inverse_of: :feedbacks

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true

  def made_by
    user.name if user_id
  end
end
