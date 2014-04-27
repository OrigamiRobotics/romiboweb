require 'spec_helper'

describe ButtonsController do

  render_views
  let(:user) {FactoryGirl.create :user}

  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
    sign_in user
  end

  def valid_attributes
    FactoryGirl.attributes_for(:button).merge(button_color_id: button_color.id)
  end

  let(:palette) { FactoryGirl.create(:palette)}
  let(:button_color) {FactoryGirl.create(:button_color)}
  let(:button) { FactoryGirl.create(:button, palette: palette)}

  describe "POST 'create'" do
    context "with invalid data" do
      describe "with missing palette id" do
        pending "returns http failure (404) with correct status and message" do
          xhr :post, 'create', button: valid_attributes
          response.should_not be_success
          response.status.should eq(404)
          JSON.parse(response.body)["error"].should == "Couldn't find Palette without an ID"
        end
      end

      describe "with non-existent palette id" do
        it "returns http failure (404) with correct status and message" do
          id =  palette.id + 1
          #puts palette.inspect
          xhr :post, 'create', button: valid_attributes.except(:user_id), palette_id: id
          response.should_not be_success
          response.status.should eq(404)
          JSON.parse(response.body)["error"].should == "Couldn't find Palette with id=#{id}"
        end
      end
    end

    context "with valid data" do
      it "creates a new Button" do
        expect {
          xhr :post, 'create', button: valid_attributes, palette_id: palette.id
        }.to change(Button, :count).by(1)
      end

      it "returns http success with correct JSON" do
        xhr :post, 'create', button: valid_attributes, palette_id: palette.id
        response.should be_success
      end


      it "returns newly created button in JSON format" do
        xhr :post, 'create', button: valid_attributes, palette_id: palette.id, format: :json
        response.should be_success
        response.header['Content-Type'].should match /json/
        json_response = JSON.parse(response.body)
        json_response["button"]['palette_id'].should eq(palette.id)
        json_response["button"]['title'].should eq(valid_attributes[:title])
        json_response["button"]['color'].should eq(button_color.value)
        json_response["button"]['speech_phrase'].should eq(valid_attributes[:speech_phrase])
        json_response["button"]['speech_speed_rate'].should eq(valid_attributes[:speech_speed_rate])
        json_response["button"]['user_id'].should eq(valid_attributes[:user_id])
      end
    end
  end

  describe "DELETE 'destroy'" do
    before do
      button.button_color_id = button_color.id
      button.save
      button1 =  FactoryGirl.create(:button, palette: palette)
      button1.button_color_id = button_color.id
      button1.save
      palette.buttons << button << button1
    end
    it 'returns http success' do
      xhr :delete, :destroy, id: button.id, palette_id: palette.id
      response.should be_success
    end
  end

end
