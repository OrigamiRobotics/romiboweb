require 'spec_helper'

describe PalettesController, palette: true do

  let(:new_palette) {FactoryGirl.build :palette}
  let(:user) {FactoryGirl.create :user}
  let(:palette) {FactoryGirl.create(:palette, owner: user)}

  before :each do
    sign_in user
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
      expect(response).to render_template 'new'
    end
  end

  describe "POST 'create'" do
    it "returns http success" do

      post 'create', palette: new_palette
      expect(response.status).to eq 200
    end
  end

  describe "GET 'edit'" do

    it 'returns http success' do
      get :edit, id: palette.id
      response.should be_success
      expect(response).to render_template 'edit'
    end

    it 'assigns palette' do
      get :edit, id: palette.id
      expect(assigns(:palette)).to eq(palette)
    end
  end

  describe "PATCH 'update'" do
    it 'returns http success' do
      put :update, id: palette.id, palette: palette.attributes
      expect(assigns(:palette)).to eq(palette)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      expect(response).to render_template 'index'
    end
  end

end
