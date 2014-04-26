require 'spec_helper'

include ButtonsControllerAssistant

describe ButtonsControllerAssistant do
  let(:user) {FactoryGirl.create :user}
  let(:palette) { FactoryGirl.create(:palette)}

  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
    sign_in user
  end

  describe "set_session_value" do
    before(:each) do
      @params   = ActionController::Parameters.new
      @session  = {}
    end

    it "sets session[:adding_button] = true when params[:status] = new" do
      @params[:status]  = 'new'
      set_session_values(@params, @session)
      @session[:adding_button].should be_true
    end

    it "sets session[:last_action] = 'new' when params[:status] = new" do
      @params[:status]  = 'new'
      set_session_values(@params, @session)
      @session[:last_action].should == 'new'
    end

    it "sets session[:adding_button] = true when (session['last_action'] == 'new' and params[:status] == 'duplicate'" do
      @params[:status]  = 'duplicate'
      @session[:last_action] = 'new'
      set_session_values(@params, @session)
      @session[:adding_button].should be_true
    end

    it "sets session[:last_action] = 'new' when (session['last_action'] == 'new' and params[:status] == 'duplicate'" do
      @params[:status]  = 'duplicate'
      @session[:last_action] = 'new'
      set_session_values(@params, @session)
      @session[:last_action].should == 'new'
    end

    context "when params[:status] != 'new' and session['last_action'] != 'new' and params[:status] != 'duplicate" do
      before(:each) do
        @params   = ActionController::Parameters.new
        @session  = {}
      end

      it "sets session[:adding_button] = false " do
        @params[:status]       = 'dummy'
        @params[:status]       = 'dummy'
        @session[:last_action] = 'dummy'
        set_session_values(@params, @session)
        @session[:adding_button].should be_false
      end

      it "sets session[:last_action] = 'not_new'" do
        @params[:status]       = 'dummy'
        @params[:status]       = 'dummy'
        @session[:last_action] = 'dummy'
        set_session_values(@params, @session)
        @session[:last_action].should == 'not_new'
      end
    end
  end

  describe "get_palette" do
    before(:each) do
      @params   = {}
      @session  = {}
    end

    context "when params[:id] is present?" do
      it "returns the palette for the button" do
        palette = FactoryGirl.create(:palette)
        button  = FactoryGirl.create(:button, palette_id: palette.id)
        @params[:id] = button.id
        returned_palette = get_palette(@params, @session)
        returned_palette.id.should == palette.id
        @session[:adding_button].should be_false
      end
    end

    context "when params[:palette_id] is present?" do
      it "returns the palette using palette_id" do
        palette = FactoryGirl.create(:palette)
        @params[:palette_id] = palette.id
        returned_palette = get_palette(@params, @session)
        returned_palette.id.should == palette.id
        @session[:adding_button].should be_false
      end
    end

    context "when neither params[:id] nor params[:palette_id] is present?" do
      it "throws ActiveRecord::RecordNotFound exception" do
        palette = FactoryGirl.create(:palette)
        @params[:something] = palette.id
        expect {
          returned_palette = get_palette(@params, @session)
        }.to raise_error(ActiveRecord::RecordNotFound)
        @session[:adding_button].should be_false
      end
    end
  end

  describe "ok_to_add?" do
    before(:each) do
      @params   = {}
      @session  = {}
    end

    it "returns true when status is present and status = new" do
      @params[:status]  = 'new'
      @session[:dummy] = 'dummy'
      ok_to_add?(@params, @session).should be_true
    end

    it "returns true when status is present and status = copy" do
      @params[:status]  = 'copy'
      @session[:dummy] = 'dummy'
      ok_to_add?(@params, @session).should be_true
    end

    it "returns true when status & keypress are present, status = duplicate, and session = adding_button" do
      @params[:keypress] = 'true'
      @params[:status]   = 'duplicate'
      @session[:adding_button] = true
      ok_to_add?(@params, @session).should be_true
    end

    it "returns false when none of the above is true" do
      @params[:status]  = 'not_copy'
      @session[:dummy] = 'not_dummy'
      @session[:adding_button] = true
      ok_to_add?(@params, @session).should be_false
    end
  end

  describe "json_create" do
    before(:each) do
      @params   = ActionController::Parameters.new
      @session  = {}
    end

    it "create new button with valid params" do
      @params[:button] = Button.default_button_params(user)
      butt = json_create(@params, palette)
      butt.present?.should be_true
      butt.palette.should == palette
    end

    it "gracefully fails to create a new button with missing user_id" do
      @params[:button] = Button.default_button_params(user).merge(user_id: nil)
      butt = json_create(@params, palette)
      butt.is_a?(Button).should be_false
      butt.to_s.should include("User can't be blank")
    end
  end

  describe "button_params" do
    before(:each) do
      @params   = ActionController::Parameters.new
      @session  = {}
      @expected = {}
    end

    it "does NOT change the speech phrase for a button when speech phrase is NOT Hello" do
      @params[:button]  = Button.default_button_params(user).merge(speech_phrase:'NOT Hello', title: "Not Untitled Button")
      @expected[:button] = Button.default_button_params(user).merge(speech_phrase:'NOT Hello', title: "Not Untitled Button")
      returned = button_params @params
      returned[:title].should == @expected[:button][:title]
      returned[:speech_phrase].should == @expected[:button][:speech_phrase]
      returned[:speech_speed_rate].should == @expected[:button][:speech_speed_rate]
      returned[:button_color_id] == @expected[:button][:button_color_id]
      returned[:size] == @expected[:button][:size]
      returned[:user_id] == @expected[:button][:user_id]
    end

    it "does NOT change the speech phrase for a button when title is Untitled Button" do
      @params[:button]  = Button.default_button_params(user).merge(speech_phrase:'Hello', title: "Untitled Button")
      @expected[:button] = Button.default_button_params(user).merge(speech_phrase:'Hello', title: "Untitled Button")
      returned = button_params @params
      returned[:title].should == @expected[:button][:title]
      returned[:speech_phrase].should == @expected[:button][:speech_phrase]
      returned[:speech_speed_rate].should == @expected[:button][:speech_speed_rate]
      returned[:button_color_id] == @expected[:button][:button_color_id]
      returned[:size] == @expected[:button][:size]
      returned[:user_id] == @expected[:button][:user_id]
    end

    it "does NOT change the speech phrase for a button when status is present" do
      @params[:button]  = Button.default_button_params(user).merge(speech_phrase: "Hello", title: "NOT Untitled Button")
      @params[:status]  = 'present'
      @expected[:button] = Button.default_button_params(user).merge(speech_phrase: "Hello", title: "NOT Untitled Button")
      returned = button_params @params
      returned[:title].should == @expected[:button][:title]
      returned[:speech_phrase].should == @expected[:button][:speech_phrase]
      returned[:speech_speed_rate].should == @expected[:button][:speech_speed_rate]
      returned[:button_color_id] == @expected[:button][:button_color_id]
      returned[:size] == @expected[:button][:size]
      returned[:user_id] == @expected[:button][:user_id]
    end

    it "changes the speech phrase for a button when all required conditions are met" do
      @params[:button]   = Button.default_button_params(user).merge(speech_phrase: "Hello", title: "NOT Untitled Button")
      @expected[:button] = Button.default_button_params(user).merge(speech_phrase: "Hello", title: "NOT Untitled Button")
      returned = button_params @params
      returned[:title].should == @params[:button][:title]
      returned[:speech_phrase].should_not == @expected[:button][:speech_phrase]
      returned[:speech_speed_rate].should == @expected[:button][:speech_speed_rate]
      returned[:button_color_id] == @expected[:button][:button_color_id]
      returned[:size] == @expected[:button][:size]
      returned[:user_id] == @expected[:button][:user_id]
    end
  end

  describe "clone_button_params" do
    before(:each) do
      @params   = ActionController::Parameters.new
      @expected = ActionController::Parameters.new
    end

    it "returns the permitted params only" do
      not_expected = {another_program: 'Another program'}
      @params[:button]   = Button.default_button_params(user).merge(not_expected)
      @expected[:button] = Button.default_button_params(user)
      returned = button_params @params

      @expected[:button].keys.each do |key|
        returned.has_key?(key).should be_true
      end

      returned.has_key?(not_expected.keys.first).should be_false
    end
  end

  describe "check_for_palette_id" do
    before(:each) do
      @params   = ActionController::Parameters.new
      @expected = ActionController::Parameters.new
    end


    # def check_for_palette_id(params)
    #   unless params[:palette_id].present?
    #     raise "Missing palette id"
    #   end
    # end
    #
    it "does not raise an exception when palette_id is present" do
      @params[:palette_id] = 1

      expect {
        check_for_palette_id @params
      }.not_to raise_exception
    end

    it "raises an exception when palette_id is NOT present" do
      expect {
        check_for_palette_id @params
      }.to raise_exception
    end
  end
end
