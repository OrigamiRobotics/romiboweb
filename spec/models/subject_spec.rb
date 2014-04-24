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

require 'spec_helper'

describe Subject, subject: true do
  let(:subject) {FactoryGirl.create(:subject)}


  [:name, :description].each do |attr|
    it {should respond_to attr}
  end
end
