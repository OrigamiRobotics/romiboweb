# require 'spec_helper'
#
# feature 'signing up', auth: true do
#
#   given(:new_user) {FactoryGirl.build :user}
#   pending 'user creating account using valid information' do
#     visit root_path
#     within('#sign_up_panel') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: new_user.email
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: new_user.password
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#     expect(page).to have_title 'Romiboweb | Unconfirmed Registration'
#   end
#
#
#   scenario 'user creating account using missing first name', js: true do
#     visit root_path
#     within('#sign_up_panel') do
#       fill_in 'user_first_name', with: ''
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: new_user.email
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: new_user.password
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "First Name can't be blank"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
#
#   scenario 'user creating account using missing last name', js: true do
#     visit root_path
#     within('#sign_up_panel') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: ''
#       fill_in 'user_email', with: new_user.email
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: new_user.password
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "Last Name can't be blank"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
#
#
#   scenario 'user creating account using missing email address', js: true do
#     visit root_path
#     within('#sign_up_panel') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: ''
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: new_user.password
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "Email can't be blank"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
#
#   scenario 'user creating account using invalid email address', js: true do
#     visit root_path
#     within('#sign_up_form') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: 'emailaddress@'
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: new_user.password
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "Email is invalid"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
#
#   scenario 'user creating account using missing password', js: true do
#     visit root_path
#     within('#sign_up_panel') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: new_user.email
#       fill_in 'user_password', with: ''
#       fill_in 'user_password_confirmation', with: new_user.password
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "Password can't be blank"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
#
#   pending 'user creating account with missing password confirmation', js: true do
#     visit root_path
#     within('#sign_up_panel div div') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: new_user.email
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: ''
#       check 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "Password confirmation doesn't match Password"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
#
#   pending 'user creating account without accepting terms' do
#     visit root_path
#     within('#sign_up_panel') do
#       fill_in 'user_first_name', with: new_user.first_name
#       fill_in 'user_last_name', with: new_user.last_name
#       fill_in 'user_email', with: new_user.email
#       fill_in 'user_password', with: new_user.password
#       fill_in 'user_password_confirmation', with: new_user.password
#       uncheck 'user_terms'
#     end
#     click_on 'Sign up'
#
#     expect(page).to have_title "Romiboweb | Home"
#     expect(page).to have_selector 'div', text: "Terms & Condition must be accepted"
#     expect(page).to have_content 'Welcome to Create.Romibo!'
#     expect(page).to have_content 'Sign In'
#     expect(page).to have_content 'Sign Up'
#     expect(page).to have_button  'Sign in'
#   end
# end
#
# def fill_form
#   visit root_path
#   within('#sign_up_panel') do
#     fill_in 'user_first_name', with: new_user.first_name
#     fill_in 'user_last_name', with: new_user.last_name
#     fill_in 'user_email', with: new_user.email
#     fill_in 'user_password', with: new_user.password
#     fill_in 'user_password_confirmation', with: new_user.password
#     check 'user_terms'
#   end
# end
