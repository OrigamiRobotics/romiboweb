class Palette < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :palette_buttons
  has_many :buttons, through: :palette_buttons
  validates_presence_of :title

end
