require 'spec_helper'

describe FeedbacksController do

  render_views

  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Orange", value: "#d45300")
  end

  let(:user) {FactoryGirl.create :user}
  let(:feedback) { FactoryGirl.create(:feedback)}

  def valid_attributes
    FactoryGirl.attributes_for(:feedback)
  end

  before :each do
    sign_in user
  end

  #describe "GET 'new'" do
  #  it "returns http success and new button" do
  #    xhr :get, 'new'
  #    assigns(:feedback).should be_a_new(Feedback)
  #  end
  #
  #  context "with missing palette id" do
  #    it "returns http faillure (404)" do
  #      xhr :get, 'new'
  #      response.should_not be_success
  #      response.status.should eq(404)
  #      JSON.parse(response.body)["error"].should == "Couldn't find Palette without an ID"
  #    end
  #  end
  #end

  #describe "POST 'create'" do
  #  context "with invalid data" do
  #    describe "with missing palette id" do
  #      it "returns http failure (404) with correct status and message" do
  #        xhr :post, 'create', button: valid_attributes
  #        response.should_not be_success
  #        response.status.should eq(404)
  #        JSON.parse(response.body)["error"].should == "Couldn't find Palette without an ID"
  #      end
  #    end
  #
  #    describe "with missing user id" do
  #      it "returns http failure (404) with correct status and message" do
  #        xhr :post, 'create', button: valid_attributes.except(:user_id), palette_id: palette.id
  #        response.should_not be_success
  #        response.status.should eq(404)
  #        puts response.body.inspect
  #        JSON.parse(response.body)["error"].should == ["User can't be blank"]
  #      end
  #    end
  #
  #    describe "with non-existent palette id" do
  #      it "returns http failure (404) with correct status and message" do
  #        id =  palette.id + 1
  #        puts palette.inspect
  #        xhr :post, 'create', button: valid_attributes.except(:user_id), palette_id: id
  #        response.should_not be_success
  #        response.status.should eq(404)
  #        JSON.parse(response.body)["error"].should == "Couldn't find Palette with id=#{id}"
  #      end
  #    end
  #  end
  #
  #  context "with valid data" do
  #    it "creates a new Feedback" do
  #      expect {
  #        xhr :post, 'create', button: valid_attributes, palette_id: palette.id
  #      }.to change(Feedback, :count).by(1)
  #    end
  #
  #    it "returns http success with correct JSON" do
  #      xhr :post, 'create', button: valid_attributes, palette_id: palette.id
  #      response.should be_success
  #    end
  #
  #
  #    it "returns newly created button in JSON format" do
  #      xhr :post, 'create', button: valid_attributes, palette_id: palette.id, format: :json
  #      response.should be_success
  #      response.header['Content-Type'].should match /json/
  #      json_response = JSON.parse(response.body)
  #
  #      json_response['button']['palette_id'].should eq(palette.id)
  #      json_response['button']['title'].should eq(valid_attributes[:title])
  #      json_response['button']['color'].should eq(button_color.value)
  #      json_response['button']['speech_phrase'].should eq(valid_attributes[:speech_phrase])
  #      json_response['button']['speech_speed_rate'].should eq(valid_attributes[:speech_speed_rate])
  #      json_response['button']['user_id'].should eq(valid_attributes[:user_id])
  #    end
  #  end
  #end
  #
  #describe "DELETE 'destroy'" do
  #  it 'returns http success' do
  #    xhr :delete, :destroy, id: button.id
  #    response.should be_success
  #  end
  #end

end
