# == Schema Information
#
# Table name: lessons
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  subject           :string(255)
#  duration          :float
#  objectives        :string(255)
#  materials         :string(255)
#  no_of_instructors :string(255)
#  student_size      :string(255)
#  preperation       :string(255)
#  notes             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Lesson, lesson: true do
  [:title, :subject, :duration, :objectives, :materials,
   :no_of_instructors, :student_size, :preparation, :notes].each do |attr|
    it {should respond_to attr}
  end
end
