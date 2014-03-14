# == Schema Information
#
# Table name: palettes
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :string(255)
#  color              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  owner_id           :integer
#  system             :boolean          default(FALSE)
#  last_viewed_button :integer
#

class Palette < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'

  has_many :palette_buttons
  has_many :buttons, through: :palette_buttons

  has_one  :last_viewed_palette

  has_many :palette_viewers
  has_many :viewers, class_name: 'User', through: :palette_viewers

  validates_presence_of :title

  attr_accessor :file

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

  def self.from_file(user, content)
    palettes_data = DefaultPalettes::PaletteFromFile.new.palette(content)
    palette = user.palettes.build(title: palettes_data.title, system: true)
    palette.save
    palettes_data.buttons.each do |b|
      button = palette.buttons.build(title: b.title, speech_phrase: b.speech,
                                     speech_speed_rate: b.speed_rate,
                                     user_id: user.id,
                                     button_color_id:   ButtonColor.find_by_name('ORANGE').id,
                                     size:              'Medium'
      )
      button.save
    end
    palette.last_viewed_button = palette.buttons.first
    palette
  end

  def current_button
    if last_viewed_button.present?
      Button.find(last_viewed_button)
    else
      return (buttons.present?) ? buttons.first : nil
    end
  end
end
