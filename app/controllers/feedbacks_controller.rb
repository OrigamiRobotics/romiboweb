class FeedbacksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_gon

  def new
    @feedback = Feedback.new
  end

  def create
    puts "++++ " + params.inspect
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user.id
    unless @feedback.save
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
