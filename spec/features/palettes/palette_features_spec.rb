require 'spec_helper'
include Warden::Test::Helpers

feature 'Editing a palette', palette: true do

  given(:user){FactoryGirl.create :user}
  given(:palette){FactoryGirl.create(:palette, owner: user)}

  scenario 'when user is not signed in' do
    visit edit_palette_path palette
    expect(page).to have_selector 'div', text: I18n.t('devise.failure.unauthenticated')
  end

  feature 'when signed-in user' do
    background {login_as user, scope: :user}

    scenario 'opens the edit form' do
      #login_as user, scope: :user
      visit edit_palette_path palette
      expect(page).to have_field I18n.t('activerecord.attributes.palette.title'), with: palette.title
      expect(page).to have_button I18n.t('palettes.edit.save')
    end

    pending 'enters invalid title' do
      visit edit_palette_path palette
      fill_in I18n.t('activerecord.attributes.palette.title'), with: ''
      click_on I18n.t('palettes.edit.save')

      expect(page).to have_selector 'div', text: "Invalid Input"
    end

    given(:new_title){Faker::Lorem.sentence}
    pending 'enters valid title' do
      visit palettes_path
      click_on palette.title
      click_on
      palette.reload
      expect(palette.title).to eq new_title
    end
  end

end