require 'spec_helper'

feature 'Sign in' do

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

end