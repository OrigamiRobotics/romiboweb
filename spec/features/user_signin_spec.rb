require 'spec_helper'

feature 'Sign in', auth: true do

  given(:new_user) {FactoryGirl.create :user}
  scenario 'registered user signing in with email and password' do
    visit new_user_session_path
    within('#sign_in_panel') do
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
    end
    click_on 'Sign in'
    expect(page).to have_title 'Dashboard'
  end

  scenario 'user signing with incorrect information' do
    visit new_user_session_path
    within('#sign_in_panel') do
      fill_in 'Email', with: 'booboo'
      fill_in 'Password', with: 'incorrect'
    end
    click_on 'Sign in'
    #expect(page).to have_title 'Home'
    expect(page).to have_content 'Invalid email or password'
  end

end