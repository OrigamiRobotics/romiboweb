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

  scenario 'user signing with incorrect email' do
    visit new_user_session_path
    within('#sign_in_panel') do
      fill_in 'Email', with: 'booboo'
      fill_in 'Password', with: new_user.password
    end
    click_on 'Sign in'

    expect(page).to have_title "Romiboweb | Home"
    expect(page).to have_selector 'div', text: 'Invalid email or password'
    expect(page).to have_content 'Welcome to RomiboWeb'
    expect(page).to have_content 'Already a member? Sign In'
    expect(page).to have_content 'New to RomiboWeb? Sign Up'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end

  scenario 'user signing with incorrect password' do
    visit new_user_session_path
    within('#sign_in_panel') do
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: 'wrong_password'
    end
    click_on 'Sign in'

    expect(page).to have_title "Romiboweb | Home"
    expect(page).to have_selector 'div', text: 'Invalid email or password'
    expect(page).to have_content 'Welcome to RomiboWeb'
    expect(page).to have_content 'Already a member? Sign In'
    expect(page).to have_content 'New to RomiboWeb? Sign Up'
    expect(page).to have_button 'Sign in'
    expect(page).to have_button 'Sign up'
  end
end