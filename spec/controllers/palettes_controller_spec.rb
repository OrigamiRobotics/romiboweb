require 'spec_helper'

describe PalettesController, palette: true do

  let(:new_palette) {FactoryGirl.build :palette}
  let(:user) {FactoryGirl.create :user}
  let(:palette) {FactoryGirl.create(:palette, owner_id: user.id)}
  let(:owned_palettes) {FactoryGirl.create_list(:palette, 5, owner_id: user.id)}
  let(:other_user) {FactoryGirl.create :user}

  def valid_attributes
    FactoryGirl.attributes_for(:palette)

  end

  before :each do
    sign_in user
  end

  describe "GET 'new'" do
    it "returns http success" do
      xhr :get, :new, format: :js
      response.should be_success
      response.header['Content-Type'].should match /javascript/
    end
  end

  describe "POST 'create'" do

    #it "returns http success" do
    #  xhr :post, :create, palette: valid_attributes
    #  response.should be_success
    #  response.header['Content-Type'].should match /javascript/
    #
    #end

    context "with valid data" do
      describe "id, title, description, color" do
        it "creates a new palette" do
          expect {
            xhr :post, 'create', palette: valid_attributes
          }.to change(Palette, :count).by(1)
        end
      end

      it "returns http success with correct JSON" do
        xhr :post, 'create', palette: valid_attributes
        response.should be_success
      end

      #it "returns newly created button in JSON format" do
      #  xhr :post, 'create', palette: valid_attributes.merge(owner_id: user.id)
      #  response.should be_success
      #  response.header['Content-Type'].should match /json/
      #  puts response.body.inspect
      #  json_response = JSON.parse(response.body)
      #
      #  json_response['owner_id'].should eq(user.id)
      #  json_response['title'].should eq(valid_attributes[:title])
      #  json_response['color'].should eq(valid_attributes[:color])
      #  json_response['description'].should eq(valid_attributes[:description])
      #end
    end


  end

  describe "GET 'edit'" do

    it 'returns http success' do
      xhr :get, :edit, id: palette.id
      response.should be_success
      response.header['Content-Type'].should match /javascript/
    end

    it 'assigns palette' do
      xhr :get, :edit, id: palette.id
      expect(assigns(:palette)).to eq(palette)
    end
  end

  describe "PATCH 'update'" do
    it 'assigns palette object' do
      put :update, id: palette.id, palette: palette.attributes
      expect(assigns(:palette)).to eq(palette)
    end
  end

  describe "GET 'index'" do
    it 'returns http success' do
      get 'index'
      response.should be_success
      expect(response).to render_template 'index'
    end

    it 'assigns palettes' do
      owned_palettes #=> this is required here so palettes are created in database.
      get 'index'
      expect(assigns(:palettes)).to eq(owned_palettes)
    end
  end

  describe "DELETE 'destroy'" do
    it 'returns http success' do
      xhr :delete, :destroy, id: palette.id
      response.should be_success
    end
  end

end
