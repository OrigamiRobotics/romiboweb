require 'spec_helper'
include Warden::Test::Helpers

feature 'Creating a button', button: true do

  given(:user){FactoryGirl.create :user}
  given(:palette){FactoryGirl.create(:palette, owner: user)}

  feature 'signed-in user' do
    background {login_as user, scope: :user}

    feature 'on the palette editor page ' do
      background {visit palettes_path}

      pending 'opens the new button form', :js => true do
        wait_for_ajax
        expect(page).to have_content 'Dashboard'
        expect(page).to have_content 'New Palette'
        expect(page).to have_content palette.title
        click_on palette.title
        click_on 'Add Button'
        expect(page).to have_field I18n.t('activerecord.attributes.palette.title'), with: palette.title
        expect(page).to have_button I18n.t('palettes.edit.save')
      end
    end
  end
end