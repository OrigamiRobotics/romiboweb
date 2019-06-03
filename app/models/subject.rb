# == Schema Information
#
# Table name: subjects
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_subjects_on_name  (name)
#

class Subject < ActiveRecord::Base
  has_many :lesson_subjects, inverse_of: :subject
  has_many :lessons, through: :lesson_subjects
end
