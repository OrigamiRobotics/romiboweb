# == Schema Information
#
# Table name: subjects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_subjects_on_name  (name)
#

class Subject < ActiveRecord::Base
  has_many :lesson_subjects, inverse_of: :subject
  has_many :lessons, through: :lesson_subjects
end
