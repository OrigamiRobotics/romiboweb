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

require 'spec_helper'

describe Subject, subject: true do
  let(:subject) {FactoryGirl.create(:subject)}


  [:name, :description].each do |attr|
    it {should respond_to attr}
  end
end
