class FeedbacksController < ApplicationController
  before_filter :set_gon
  respond_to :js, :html

  def new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user.id
    unless @feedback.save
      @feedbacks = Feedback.all.order('created_at desc')
      flash[:alert] = "Failed to create feedback. #{@feedback.errors.full_messages.join(". ")}"
    end
  end

  def index
    @feedbacks = Feedback.all.order('created_at desc')
    @feedback = Feedback.new
  end

  private
  def feedback_params
    params.require(:feedback).permit(:name, :email, :title, :content)
  end
end
