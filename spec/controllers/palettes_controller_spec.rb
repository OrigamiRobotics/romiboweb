# == Schema Information
#
# Table name: palettes
#
#  id                   :bigint           not null, primary key
#  title                :string
#  description          :string
#  color                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  owner_id             :integer
#  system               :boolean          default(FALSE)
#  last_viewed_button   :integer
#  all_buttons_selected :boolean          default(FALSE)
#

require 'spec_helper'

describe PalettesController, palette: true do
  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
  end

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

    it "returns http success" do
      xhr :post, :create, palette: valid_attributes
      response.should be_success
      response.header['Content-Type'].should match /javascript/
    end

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

    it "returns updated palette in JSON format" do
      xhr :put, 'update', id: palette.id, palette: palette.attributes, format: :json
      response.should be_success
      response.header['Content-Type'].should match /json/
      json_response = JSON.parse(response.body)

      json_response["name"].should eq(palette.title)
    end
  end

  describe "GET 'index'" do
    it 'returns http success' do
      get 'index'
      response.should be_success
      expect(response).to render_template 'index'
    end

    it 'assigns palettes' do
      #palettes = owned_palettes #=> this is required here so palettes are created in database.
      get 'index'
      palettes = assigns(:palettes)
      owned_palettes.each do |palette|
        expect(palettes.pluck(:id)).to include(palette.id)
      end
    end
  end

  describe "DELETE 'destroy'" do
    it 'returns http success' do
      xhr :delete, :destroy, id: palette.id
      response.should be_success
    end
  end

end
