# == Schema Information
#
# Table name: palettes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  color       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  owner_id    :integer
#

class Palette < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :palette_buttons
  has_many :buttons, through: :palette_buttons
  has_one  :last_viewed_palette
  validates_presence_of :title


  include DefaultPalettes

  def self.default_palettes(user)
    palettes_data = DefaultPalettes::SystemPaletteData.new.palettes
    palettes_data.each do |data|
      palette = user.palettes.build(title: data.title, system: true)
      palette.save
      data.buttons.each do |b|
        button = palette.buttons.build(title: b.title, speech_phrase: b.speech,
                              speech_speed_rate: b.speed_rate,
                              user_id: user.id,
                              button_color_id:   ButtonColor.find_by_name('ORANGE').id,
                              size:              'Medium'
        )
        button.save
      end
    end
  end

  def current_button
    (last_viewed_button.present?) ?
        Button.find(last_viewed_button) :
        buttons.first
  end
end
