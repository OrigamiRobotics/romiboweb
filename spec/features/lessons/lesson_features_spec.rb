require 'spec_helper'
include Warden::Test::Helpers

feature 'User creating new lesson', lesson: true do
  given(:user) {FactoryGirl.create :user}
  background {login_as user, scope: :user}

  feature 'the form' do
    background {visit new_lesson_path}
    scenario "should contain 'New Lesson' title" do
      expect(page).to have_title I18n.t 'lessons.new.title'
    end
    scenario 'should contain the following fields' do
      %w(title subject duration objectives materials
          no_of_instructors student_size preparation notes).each do |attr|
        expect(page).to have_field I18n.t "activerecord.attributes.lesson.#{attr}"
      end
    end
  end
end
