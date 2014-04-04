# == Schema Information
#
# Table name: lessons
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  subject           :string(255)
#  duration          :integer
#  objectives        :string(255)
#  materials         :string(255)
#  no_of_instructors :string(255)
#  student_size      :string(255)
#  preparation       :string(255)
#  notes             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

class Lesson < ActiveRecord::Base
  
  CLASS_SIZES = %w(1 2 Small Large)

  acts_as_taggable
  
  belongs_to :user

  
end
