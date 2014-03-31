class LessonsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    @lesson = Lesson.new
  end

end