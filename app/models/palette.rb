# Palette contains buttons that may be used as part of a lesson.  Palette can also be considered as a Category.
#
# a. Id: Auto generated unique identifier
# b. Title: Palette title used to represent the palette.
# c. Color: Palette color used to represent font color of title.
# d. Owner: User who created the palette.
# e. Users: users with whom the palette is shared. All shared users get read-only access to the palette.
#    In order to edit a shared palette, the system clones the existing palette and assigns it to the current user.
# f. Buttons: Association with Button contained in the palette.
#
# == Schema Information
#
# Table name: palettes
#
#  id                   :integer          not null, primary key
#  title                :string(255)
#  description          :string(255)
#  color                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  owner_id             :integer
#  system               :boolean          default(FALSE)
#  last_viewed_button   :integer
#  all_buttons_selected :boolean          default(FALSE)
#

class Palette < ActiveRecord::Base
  
  
  belongs_to :owner, class_name: 'User'
  has_many :palette_buttons
  has_many :palette_lessons
  has_many :lessons, through: :palette_lessons
  has_many :buttons, dependent: :destroy
  has_many :palette_viewers
  has_many :viewers, class_name: 'User', through: :palette_viewers
  has_many :recommended_palettes, inverse_of: :palette, dependent: :destroy

  has_one  :last_viewed_palette
  accepts_nested_attributes_for :buttons, 
                                allow_destroy: true


  validates_presence_of :title

  attr_accessor :file, :speech_speed_rate, :button_color, :size, :speech_phrase

  extend DefaultPalette

  def self.default_palettes(user)
    palettes_data = {"I Spy" => i_spy, "Simon Says" => simon_says,
                     "Tell me a Story" => tell_me_a_story, "Draw with me" => draw_with_me}
    palettes_data.each do |palette_title, buttons_data|
      palette = user.palettes.build(title: palette_title, system: true)
      palette.save
      buttons_data.each do |b_title|
        button = palette.buttons.build(title: b_title, speech_phrase: b_title,
                              speech_speed_rate: 0.2,
                              user_id: user.id,
                              button_color_id:   ButtonColor.find_by_name('Turquoise').id,
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
                                     button_color_id:   ButtonColor.find_by_name('Turquoise').id,
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
      return nil unless Button.exists?(last_viewed_button)
      Button.find(last_viewed_button) || nil
    else
      (buttons.present?) ? buttons.first : nil
    end
  end

  def number_of_selected_buttons
    selected_buttons.size
  end

  # when a single button is selected
  # we use this to check whether or not
  # all buttons have been selected after this one
  # button was selected
  def just_selected_all_buttons?
    (buttons.size > 0) && number_of_selected_buttons == buttons.size
  end

  def selected_buttons
    buttons.where{ selected == true}
  end

  def set_common_values(button)
    speech_speed_rate = button.speech_speed_rate
    button_color      = button.button_color_id
    size              = button.size
  end

  def delete_buttons
    update_attributes(last_viewed_button: nil)
    Button.delete(selected_buttons.pluck(:id))
    just_selected_all_buttons? ? update_attributes(all_buttons_selected: true) : update_attributes(all_buttons_selected: false)
  end

  def add_buttons(buttons_array)
    buttons_array.each do |button|
      new_button = buttons.build(button)
      new_button.save
    end
  end

  def add_default_button
    buttons.build(Button.default_button_params(owner)) unless buttons.any?
    save
  end

  def self.recommend(palette_ids, user_ids)
    palette_ids.each do |recommended_palette_id|
      user_ids.each do  |recommended_user_id|
        RecommendedPalette.create(palette_id: recommended_palette_id.to_i,
                                  user_id:    recommended_user_id.to_i)
      end
    end
  end

  def recommended?(user)
    (user.present? && self.owner.present? && self.owner.id.present?) ? user.id != self.owner.id : false
  end

  def self.clone(source, user)
    palette = user.palettes.build(title: source.title,
                     description: source.description,
                     color: source.color
    )
    palette.save
    source.buttons.each do |button|
      button = palette.buttons.build(button.hash_params.merge(user_id: user.id))
      button.save
    end
    palette
  end
end
