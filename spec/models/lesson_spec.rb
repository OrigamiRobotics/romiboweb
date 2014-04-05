# == Schema Information
#
# Table name: lessons
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  subject           :text
#  duration          :integer
#  objectives        :text
#  materials         :text
#  no_of_instructors :string(255)
#  student_size      :string(255)
#  preparation       :text
#  notes             :text
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

require 'spec_helper'

describe Lesson, lesson: true do
  [:title, :subject, :duration, :objectives, :materials,
   :no_of_instructors, :student_size, :preparation, 
   :notes, :tag_list].each do |attr|
    it {should respond_to attr}
  end

  it {should belong_to :user}
end
