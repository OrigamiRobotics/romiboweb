require 'spec_helper'

describe Palettes::ShareController, palette: true, share: true do
  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Orange", value: "#d45300")
  end

  let(:user){FactoryGirl.create :user}
  let(:other_user){FactoryGirl.create :user}
  let(:palette){FactoryGirl.create :palette, owner_id: user.id}

  describe "GET 'new'" do
    before do
      get 'new', palette_id: palette.id, format: :js
    end

    it {should respond_with 200}
    it {should render_template 'new'}
    it 'should assign palette' do
      expect(assigns(:palette)).to eq(palette)
    end
    #it 'returns http success' do
    #  get 'new'
    #  response.should be_success
    #end
  end

  pending "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
