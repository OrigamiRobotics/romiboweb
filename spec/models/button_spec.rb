# == Schema Information
#
# Table name: buttons
#
#  id                :bigint           not null, primary key
#  title             :string           not null
#  speech_phrase     :string
#  speech_speed_rate :float
#  user_id           :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  button_color_id   :bigint
#  size              :string
#  row               :integer
#  col               :integer
#  selected          :boolean          default(FALSE)
#  palette_id        :bigint
#
# Indexes
#
#  index_buttons_on_button_color_id  (button_color_id)
#  index_buttons_on_palette_id       (palette_id)
#  index_buttons_on_size             (size)
#  index_buttons_on_user_id          (user_id)
#

require 'spec_helper'

describe Button do
  let(:button_color) { FactoryGirl.create(:button_color)}
  let(:user) { FactoryGirl.create(:user)}
  let(:palette) { FactoryGirl.create(:palette, owner_id: user.id)}
  let(:button) { FactoryGirl.create(:button, button_color_id: button_color.id, palette_id: palette.id)}

  subject { button}

  context "should have the following attributes" do
    [:title, :speech_phrase, :speech_speed_rate,
     :color, :user, :palette, :palette_id, :button_color,
     :size, :div_id].each do |attr|
      it { should respond_to attr }
    end
  end

  it "should return correct id for div" do
    expect(button.div_id).to eql("buttonId_#{button.id}")
  end

  context "should not be valid without a title" do
    before { button.title = "" }
    it { should_not be_valid }
  end

  context "should not be valid non-numeric speech speed rate" do
    before { button.speech_speed_rate = "some value" }
    it { should_not be_valid }
  end

  context "should not be valid without user id" do
    before { button.user_id = nil }
    it { should_not be_valid }
  end

  context "should not be valid without button_color_id" do
    before { button.button_color_id = nil }
    it { should_not be_valid }
  end

  context "should not be valid when size is not one of Small, Medium, or Large" do
    before { button.size = 'Not small or medium or large' }
    it { should_not be_valid }
  end

  context "should not be valid without size" do
    before { button.size = '' }
    it { should_not be_valid }
  end

  context "should not be valid palette_id" do
    before { button.palette_id = nil }
    it { should_not be_valid }
  end

  context "div id" do
    it "should return correct div id" do
      button.div_id.should == "buttonId_#{button.id}"
    end
  end

  context "has_params" do
    it "should return correct has params for button" do
      hp = { title: button.title,
             speech_phrase: button.speech_phrase,
             speech_speed_rate: button.speech_speed_rate,
             button_color_id: button.button_color_id,
             size: button.size,
             user_id: button.user_id
      }
      button.hash_params.should == hp
    end
  end


  context "default params" do
    it "should return the correct default button params" do
      default_params = { title: "I'm a button",
                         speech_phrase: "This is what I say",
                         speech_speed_rate: 0.2,
                         button_color_id: button_color.id,
                         size: "Medium",
                         user_id: user.id
      }

      default_params = Button.default_button_params(user)

      default_params[:title].should == default_params[:title]
      default_params[:speech_phrase].should == default_params[:speech_phrase]
      default_params[:speech_speed_rate].should == default_params[:speech_speed_rate]
      default_params[:button_color_id].should == default_params[:button_color_id]
      default_params[:size].should == default_params[:size]
      default_params[:user_id].should == default_params[:user_id]

    end
  end

  describe "ButtonCreator mixin" do
    before(:each) do
      @params   = {}
      @session = {}
    end

    context "default values" do
      it "returns the correct default button params" do
        expect_default_values = {
            title:             'Untitled Button',
            speech_phrase:     'Hello',
            speech_speed_rate: 0.2,
            button_color_id:   button_color.id,
            size:              'Medium',
            user_id:           user.id
        }

        returned_default_values = Button.default_values user
        returned_default_values[:title].should             == expect_default_values[:title]
        returned_default_values[:speech_phrase].should     == expect_default_values[:speech_phrase]
        returned_default_values[:speech_speed_rate].should == expect_default_values[:speech_speed_rate]
        ButtonColor.find(returned_default_values[:button_color_id]).name.should == ButtonColor.find(expect_default_values[:button_color_id]).name
        returned_default_values[:size].should              == expect_default_values[:size]
        returned_default_values[:user_id].should           == expect_default_values[:user_id]
      end
    end

    context "clone button params" do
      it "returns the correct clone button params" do
        params = ActionController::Parameters.new(button: button.hash_params)
        returned_button_params = Button.clone_button_params params
        returned_button_params[:title].should             == params[:button][:title]
        returned_button_params[:speech_phrase].should     == params[:button][:speech_phrase]
        returned_button_params[:speech_speed_rate].should == params[:button][:speech_speed_rate]
        returned_button_params[:button_color_id].should   == params[:button][:button_color_id]
        returned_button_params[:size].should              == params[:button][:size]
        returned_button_params[:user_id].should           == params[:button][:user_id]
      end
    end

    context "create button for JS request" do
      before(:each) do
        @params = ActionController::Parameters.new(button: button.hash_params)
        @session = {}
        @palette = FactoryGirl.create(:palette, owner_id: user.id)
      end

      it "makes a copy of button when params[:status] = 'copy'" do
        @params[:status] = 'copy'
        cloned_button  = Button.js_create(@params, @palette, @session, user)
        cloned_button.hash_params.should == button.hash_params
      end

      it "sets last viewed button for parent palette to the newly cloned button" do
        @params[:status] = 'copy'
        cloned_button  = Button.js_create(@params, @palette, @session, user)
        cloned_button.palette.last_viewed_button.should == cloned_button.id
      end

      it "creates a new button with default values when 'copy' is not specified" do
        created_button  = Button.js_create(@params, @palette, @session, user)
        created_button.hash_params.should == Button.default_values(user)
      end

      it "sets session status to last_action to new" do
        created_button  = Button.js_create(@params, @palette, @session, user)
        @session[:last_action].should == 'new'
      end

      it "sets last viewed button for parent palette the newly created button" do
        created_button  = Button.js_create(@params, @palette, @session, user)
        created_button.palette.last_viewed_button.should == created_button.id
      end
    end

  end

  describe "ButtonUpdater mixin" do
    context "update_parent_palette" do
      it "updates the parent palette" do
        button.palette_id.should == palette.id
        button.update_parent_palette
        button.palette.last_viewed_button.should == button.id
      end
    end

    context "toggles button selection when params[:mode] == 'multiple'" do
      before(:each) do
        @params = ActionController::Parameters.new
      end

      it "sets selected to true if selected is currently false" do
        @params[:mode] = 'multiple'
        button.selected = false
        button.save
        button.selected?.should be_false
        button.set_selection(@params)
        button.selected?.should be_true
      end

      it "sets all buttons selected to true after selecting all buttons" do
        @params[:mode] = 'multiple'
        button.selected = false
        button.save
        button.selected?.should be_false
        button.set_selection(@params)
        button.palette.all_buttons_selected.should be_true
      end

      it "sets selected to false if selected is currently true" do
        @params[:mode] = 'multiple'
        button.selected = true
        button.save
        button.selected?.should be_true
        button.set_selection(@params)
        button.selected?.should be_false
      end

      it "sets all buttons selected to false when not all buttons are selected" do
        @params[:mode] = 'multiple'
        button.selected = true
        button.save
        button.selected?.should be_true
        button.set_selection(@params)
        button.palette.all_buttons_selected.should be_false
      end

      it "does nothing if params[:mode] != 'multiple' when selected is currently true" do
        @params[:mode] = 'not_multiple'
        button.selected = true
        button.save
        button.selected?.should be_true
        button.set_selection(@params)
        button.selected?.should be_true
      end

      it "does nothing if params[:mode] != 'multiple' when selected is currently false" do
        @params[:mode] = 'not_multiple'
        button.selected = false
        button.save
        button.selected?.should be_false
        button.set_selection(@params)
        button.selected?.should be_false
      end
    end
  end
end
