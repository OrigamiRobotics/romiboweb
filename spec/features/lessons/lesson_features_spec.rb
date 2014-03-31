require 'spec_helper'
include Warden::Test::Helpers

feature 'User creating new lesson', lesson: true do
  given(:user) {FactoryGirl.create :user}
  given(:lesson) {FactoryGirl.create :lesson}
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

  feature 'filling and submitting form' do
    background do
      visit new_lesson_path
      %w(title subject objectives materials preparation notes).each do |attr|
        fill_in I18n.t("activerecord.attributes.lesson.#{attr}"), with: "lesson.#{attr}"
      end
      page.select(lesson.duration, from: I18n.t('activerecord.attributes.lesson.duration'))
      page.select(lesson.no_of_instructors, from: I18n.t('activerecord.attributes.lesson.no_of_instructors'))
      page.select(lesson.student_size, from: I18n.t('activerecord.attributes.lesson.student_size'))
    end
    scenario 'should create new lesson' do
      expect{click_button 'Create Lesson'}.to change(Lesson, :count).by(1)
    end
  end
end
