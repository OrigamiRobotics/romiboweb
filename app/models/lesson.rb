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

class Lesson < ActiveRecord::Base
  
  CLASS_SIZES = %w(1 2 Small Large)

  acts_as_taggable
  
  belongs_to :user
  has_many :palette_lessons
  has_many :palettes, through: :palette_lessons
  has_one :attachment, as: :attachable, dependent: :delete


end
