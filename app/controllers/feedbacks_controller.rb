class FeedbacksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_gon

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user.id
    if @feedback.save
      Notification.user_feedback(current_user, @feedback).deliver
    else
      @feedbacks = Feedback.all.order('created_at desc')
      flash[:alert] = "Failed to create feedback. #{@feedback.errors.full_messages.join(". ")}"
    end
  end

  def index
    @title = "Feedback"
    @feedbacks = Feedback.all.order('created_at desc')
    @feedback = Feedback.new
  end

  private
  def feedback_params
    params.require(:feedback).permit(:title, :content, :user_id)
  end
end
