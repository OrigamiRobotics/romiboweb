# == Schema Information
#
# Table name: lessons
#
#  id                :bigint           not null, primary key
#  title             :string
#  subject           :text
#  duration          :integer
#  objectives        :text
#  materials         :text
#  no_of_instructors :string
#  student_size      :string
#  preparation       :text
#  notes             :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_lessons_on_user_id  (user_id)
#

require 'spec_helper'

describe Lesson, lesson: true do
  [:title, :subjects, :duration, :objectives, :materials,
   :no_of_instructors, :student_size, :preparation, 
   :notes, :tag_list, :lesson_subjects].each do |attr|
    it {should respond_to attr}
  end

  it {should belong_to :user}
  it {should have_one  :attachment}
  it {should have_many :subjects}
  it {should have_many :lesson_subjects}
  it {should have_many :recommended_lessons}

end
