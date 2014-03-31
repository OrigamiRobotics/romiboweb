class LessonsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = 'Lesson successfully created'
    else
      flash[:danger] = 'Could not create lesson'
    end
    render 'new'
  end

  private
  def lesson_params
    params.require(:lesson).permit(
        :title, :subject, :duration, :objectives, :materials,
        :no_of_instructors, :student_size, :preparation, :notes
    )
  end

end