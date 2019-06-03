class FeedbacksController < ApplicationController
  before_action :set_gon
  respond_to :js, :html

  def new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if user_signed_in?
      @feedback.user_name = current_user.full_name
      @feedback.user_email = current_user.email
    end
    if @feedback.save
      FeedbackMailer.email(@feedback, feedback_params[:save_screenshot] == '1').deliver
      flash[:success] = 'Thanks for sharing your feedback!'
    else
      render 'new'
    end
  end

  def index
    @feedbacks = Feedback.all.order('created_at desc')
    @feedback = Feedback.new
  end

  private
  def feedback_params
    params.require(:feedback).permit(
        :user_name, :user_email, :statement,
        :description, :save_screenshot, :page_uri
    )
  end
end
