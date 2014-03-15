class FeedbacksController < ApplicationController
  before_filter :set_gon
  respond_to :js, :html

  def new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if user_signed_in?
      @feedback.name = current_user.full_name
      @feedback.email = current_user.email
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
    params.require(:feedback).permit(:name, :email, :title, :content, :save_screenshot, :page_uri)
  end
end
