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

  has_many :palette_viewers
  has_many :viewers, class_name: 'User', through: :palette_viewers

  validates_presence_of :title

  attr_accessor :file

  extend DefaultPalette

  def self.default_palettes(user)
    palettes_data = {"I Spy" => i_spy, "Simon Says" => simon_says,
                     "Tell me a Story" => tell_me_a_story, "Draw with me" => draw_with_me}
    palettes_data.each do |palette_title, buttons_data|
      palette = user.palettes.build(title: palette_title, system: true)
      palette.save
      buttons_data.each do |b_title|
        button = palette.buttons.build(title: b_title, speech_phrase: b_title,
                              speech_speed_rate: 2,
                              user_id: user.id,
                              button_color_id:   ButtonColor.find_by_name('Orange').id,
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
                                     user_id:           user.id,
                                     button_color_id:   ButtonColor.find_by_name('Orange').id,
                                     size:              'Medium'
      )
      button.save
    end
    palette.last_viewed_button = palette.buttons.first
    palette.save
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
