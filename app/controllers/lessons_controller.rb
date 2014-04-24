class LessonsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user

    puts params.inspect
    params[:lesson][:palette_ids].each do |palette_id|
      unless palette_id.empty?
        @lesson.palette_lessons.build(:palette_id => palette_id)
      end
    end unless params[:lesson][:palette_ids].blank?

    params[:lesson][:subject_ids].each do |subject_id|
      unless subject_id.blank?
        @lesson.lesson_subjects.build(:subject_id => subject_id)
      end
    end  unless params[:lesson][:subject_ids].blank?

    @lesson.build_attachment name: params[:lesson][:attachment] unless
    params[:lesson][:attachment].blank?

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
  
  def edit
    @lesson = Lesson.find params[:id]
  end
  
  def update
    @lesson = Lesson.find params[:id]
    
    unless @lesson.user == current_user
      flash[:danger] = 'You are not authorized!'
      respond_with @lesson and return
    end
    
    unless params[:lesson][:attachment].blank?
      @lesson.attachment.delete if @lesson.attachment.present?
      @lesson.create_attachment name: params[:lesson][:attachment] 
    end
    
    if @lesson.update_attributes lesson_params
      flash[:success] = 'Lesson updated!'
      respond_with @lesson
    else
      flash[:danger] = 'Could not update lesson'
      render 'edit' and return
    end
  end
  
  def destroy
    @lesson = Lesson.find params[:id]
    
    unless @lesson.user == current_user
      flash[:danger] = 'You are not authorized!'
      respond_with @lesson and return
    end
    
    @lesson.delete
    redirect_to lessons_path 
  end
  
  

  private
  def lesson_params
    params.require(:lesson).permit(
        :title, :subject, :duration, :objectives, :materials,
        :no_of_instructors, :student_size, :preparation, 
        :notes, :tag_list, :palette_ids, :subject_ids
    )
  end

end
