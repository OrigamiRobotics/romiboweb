class LessonsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user
    if @lesson.save
      flash[:success] = 'Lesson created!'
      respond_with @lesson
    else
      flash[:danger] = 'Could not create lesson'
    end
  end
  
  def index
    @lessons = current_user.lessons
  end
  
  def show
    @lesson = Lesson.find params[:id]
  end

  private
  def lesson_params
    params.require(:lesson).permit(
        :title, :subject, :duration, :objectives, :materials,
        :no_of_instructors, :student_size, :preparation, 
        :notes, :tag_list
    )
  end

end
