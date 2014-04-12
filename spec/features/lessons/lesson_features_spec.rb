require 'spec_helper'
include Warden::Test::Helpers

feature 'Features for lesson', lesson: true do
  given(:user) {FactoryGirl.create :user}
  given(:lesson) {FactoryGirl.create :lesson, user: user}
  background {login_as user, scope: :user}
  
  feature 'When I navigate to new lesson page' do
    feature 'then the form' do
      background {visit new_lesson_path}
      scenario "should contain 'New Lesson' title" do
        expect(page).to have_title I18n.t 'lessons.new.title'
      end
      scenario 'should contain required fields' do
        %w(title subject duration objectives materials
            no_of_instructors student_size preparation notes tag_list).each do |attr|
          expect(page).to have_field I18n.t "activerecord.attributes.lesson.#{attr}"
        end
      end
    end
  end


  feature 'when I fill and submit form' do
    background do
      fill_new_lesson_form
    end
    scenario 'should create new lesson' do
      expect{click_button 'Create Lesson'}.to change(Lesson, :count).by(1)
    end
    
    feature 'and adding tags' do
      scenario 'should associate tags with lesson' do
        fill_in I18n.t('activerecord.attributes.lesson.tag_list'), with: 'test'
        click_button 'Create Lesson'
        Lesson.last.tag_list.include?('test').should be_true 
      end
    end
    
    feature 'and adding attachment' do
      background {
        attach_file I18n.t('activerecord.attributes.lesson.attachment'),
                    'README.txt'
      }
      scenario 'should create new attachment' do
        expect{click_button 'Create Lesson'}
        .to change(Attachment, :count).by(1)  
      end
    end
    
  end
  
  feature 'when I navigate to lesson page' do
    background {visit lesson_path lesson}
    feature 'then the page' do
      scenario 'should have lesson title' do
        expect(page).to have_title lesson.title
      end
      scenario 'should have lesson subject' do
        expect(page).to have_content lesson.subject
      end
      scenario 'should have lesson author name' do
        expect(page).to have_content lesson.user.full_name
      end
    end
    feature 'and I am the author' do
      feature 'then the lesson page' do
        scenario 'should have an edit button' do
          expect(page).to have_link 'edit_lesson'
        end
        scenario 'should have a delete button' do
          expect(page).to have_link 'delete_lesson'
        end
      end
    end
    feature 'and I am not the author' do
      given(:other_user) {FactoryGirl.create :user}
      given(:other_lesson) {FactoryGirl.create :lesson, user: other_user}
      feature 'then the lesson page' do
        background {visit lesson_path other_lesson}
        scenario 'should not have edit button' do
          expect(page).to have_no_link 'edit_lesson'
        end
        scenario 'should not have delete button' do
          expect(page).to have_no_link 'delete_lesson'
        end
      end
    end
  end
  
  feature 'when I edit a lesson' do
    background do
      @title = 'Edited title'
      visit edit_lesson_path lesson
      fill_in I18n.t('activerecord.attributes.lesson.title'), with: @title
      click_button 'Update Lesson'
    end
    scenario 'then lesson title should change' do
      expect(page).to have_title @title    
    end
  end
  
  # Not working with the confirm box
  pending 'when I click delete lesson button' do
    background do
      visit lesson_path lesson
      click_on 'delete_lesson'
    end
    scenario 'then I should be asked to confirm' do
      page.driver.browser.switch_to.alert.accept
    end
    feature 'and I confirm delete' do
      scenario 'then lesson should be deleted'
    end
  end
  
  def fill_new_lesson_form
    visit new_lesson_path
    %w(title subject objectives materials preparation notes).each do |attr|
      fill_in I18n.t("activerecord.attributes.lesson.#{attr}"), with: lesson.send(attr)
    end
    page.select(lesson.duration, from: I18n.t('activerecord.attributes.lesson.duration'))
    page.select(lesson.no_of_instructors, from: I18n.t('activerecord.attributes.lesson.no_of_instructors'))
    page.select(lesson.student_size, from: I18n.t('activerecord.attributes.lesson.student_size'))
  end
end
