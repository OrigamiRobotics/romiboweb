require 'spec_helper'

describe LessonsController, lesson: true do

  let(:user) {FactoryGirl.create :user}
  let(:lesson) {FactoryGirl.build :lesson}
  let(:saved_lesson) {FactoryGirl.create :lesson}
  let(:lessons) {FactoryGirl.create_list :lesson, 5, user_id: user.id}
  before :each do
    sign_in user
  end
  describe "GET 'new'" do
    before { get :new }

    # TODO: find a way to DRY this out for all controller specs
    #it { should use_before_filter :authenticate_user! } #=> This is part of shoulda-matchers spec v2.5.0,
    # not sure why it is not working with our code.
    describe 'when no user is signed in' do
      before do
        sign_out user
        get :new
      end
      it { should redirect_to '/' }
    end

    it { should respond_with 200 }
    it { should render_template 'new' }
    it 'should assign new lesson' do
      expect(assigns(:lesson)).to be_a_new Lesson
    end
  end

  describe "POST 'create'" do
    before {post :create, lesson: lesson.attributes}
    #[:title, :subject, :duration, :objectives, :materials,
    # :no_of_instructors, :student_size, :preparation, :notes].each do |attr|
    #  pending {should permit(attr).for(:create)}
    #end
    it 'should create a new lesson' do
      expect{post :create, lesson: lesson.attributes}
      .to change(Lesson, :count).by 1
    end
  end
  
  describe "GET 'index'" do
    before do
      lessons # invoking lessons 
      get :index
    end
    it {should respond_with :ok}
    it {should render_template 'index'}
    it "should assign current user's lessons" do
      expect(assigns(:lessons)).to eq(lessons)
    end
  end
  
  describe "GET 'edit'" do
    before { get :edit, id: saved_lesson.id }
    it {should respond_with :ok}
    it {should render_template 'edit'}
    it 'should assign lesson' do
      expect(assigns(:lesson)).to eq(saved_lesson)
    end
  end

  describe "PUT 'update'" do
    before do
      @edited_lesson = saved_lesson.dup
      @edited_lesson.title = 'Edited Title'
      put :update, id: saved_lesson.id, lesson: @edited_lesson.attributes
    end
    it 'should update the lesson' do
      Lesson.find(saved_lesson.id).title == @edited_lesson.title
    end
  end
end
