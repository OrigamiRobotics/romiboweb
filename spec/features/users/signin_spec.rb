require 'spec_helper'

feature 'Sign in', auth: true do
  before(:each) do
    @button_color ||= ButtonColor.find_or_create_by(name: "Turquoise", value: "#13c8b0")
  end

  given(:new_user) {FactoryGirl.create :user}
  scenario 'registered user signing in with email and password' do
    visit new_user_session_path
    within('#sign_in_form') do
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
    end
    click_on 'Sign in'
    expect(page).to have_title 'Dashboard'
  end

  scenario 'user signing with incorrect email' do
    visit new_user_session_path
    within('#sign_in_form') do
      fill_in 'Email', with: 'booboo'
      fill_in 'Password', with: new_user.password
    end
    click_on 'Sign in'

    expect(page).to have_title "Romiboweb | Home"
    expect(page).to have_selector 'div', text: 'Invalid email or password'
    expect(page).to have_content 'Welcome to Create.Romibo!'
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_button  'Sign in'
  end

  scenario 'user signing with incorrect password' do
    visit new_user_session_path
    within('#sign_in_form') do
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: 'wrong_password'
    end
    click_on 'Sign in'

    expect(page).to have_title "Romiboweb | Home"
    expect(page).to have_selector 'div', text: 'Invalid email or password'
    expect(page).to have_content 'Welcome to Create.Romibo!'
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_button  'Sign in'
  end
end
