require 'spec_helper'

describe LessonsController, lesson: true do

  let(:user) {FactoryGirl.create :user}
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
    it 'should return http success'
  end
end