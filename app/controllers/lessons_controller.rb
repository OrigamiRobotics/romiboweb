class LessonsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user

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

    handle_palettes
    handle_subjects

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

  def handle_palettes
    @lesson.palette_lessons.each do |palette_lesson|
      palette_lesson.delete unless params[:lesson][:palette_ids].include?palette_lesson
    end

    params[:lesson][:palette_ids].each do |palette_id|
      unless palette_id.empty?
        @lesson.palette_lessons.build(:palette_id => palette_id) unless PaletteLesson.find_by_palette_id_and_lesson_id(palette_id, @lesson.id).present?
      end
    end unless params[:lesson][:palette_ids].blank?
  end

  def handle_subjects
    @lesson.lesson_subjects.each do |lesson_subject|
      lesson_subject.delete unless params[:lesson][:subject_ids].include?lesson_subject
    end

    params[:lesson][:subject_ids].each do |subject_id|
      unless subject_id.blank?
        @lesson.lesson_subjects.build(:subject_id => subject_id) unless LessonSubject.find_by_subject_id_and_lesson_id(subject_id, @lesson.id).present?
      end
    end  unless params[:lesson][:subject_ids].blank?
  end
end
