require 'spec_helper'

feature 'signing up', auth: true do

  given(:new_user) {FactoryGirl.build :user}
  scenario 'user creating account using email and password' do
    visit root_path
    within('#sign_up_panel') do
      fill_in 'First Name', with: new_user.first_name
      fill_in 'Last Name', with: new_user.last_name
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
      fill_in 'Password confirmation', with: new_user.password
    end
    click_on 'Sign up'
    expect(page).to have_title 'Dashboard'
  end

end