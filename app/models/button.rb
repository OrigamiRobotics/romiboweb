# Button represents a Palette action.
#
# a. Id: Auto generated unique identifier
# b. Title: Button title
# c. Speech Text: Text to be spoken when the button is tapped. If speech text is not available, button title is used as speech text.
# d. Color: ButtonColor
# e. Type: Denotes 3 predefined sizes.
#    1. Small: 50x100 px, title only
#    2. Medium: 100x100px, title or image
#    3. Large: 100x200px, both title and image can be added
# f. Position: denotes position of button relative to the palette
# g. Speech Rate: A floating point integer between 0 and 1 to denote the speech rate.
# h. Gesture: Driving motion or Neck Motion
# i. Palettes: Association with palettes that contain this button.
# j. Owner: User who created the button. Only owner can edit/delete the button.
#
# == Adding a Button
#
# Button is added through the Palette Editor on the right hand pane.
#
# == Schema Information
#
# Table name: buttons
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  speech_phrase     :string(255)
#  speech_speed_rate :float
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  button_color_id   :integer
#  size              :string(255)
#  row               :integer
#  col               :integer
#  selected          :boolean          default(FALSE)
#  palette_id        :integer
#
# Indexes
#
#  index_buttons_on_button_color_id  (button_color_id)
#  index_buttons_on_palette_id       (palette_id)
#  index_buttons_on_size             (size)
#  index_buttons_on_user_id          (user_id)
#

class Button < ActiveRecord::Base
  before_create :ensure_position

  default_scope { order(:row, :col) }
  
  has_many :palette_buttons
  has_many :palettes, through: :palette_buttons

  belongs_to :user, inverse_of: :buttons
  belongs_to :button_color, inverse_of: :buttons
  belongs_to :palette, inverse_of: :buttons

  validates :title, presence: true
  validates :speech_speed_rate, numericality: true
  validates :user_id, presence: true
  validates :button_color_id, presence: true
  validates :size, presence: true, inclusion: { in: %w(small Small medium Medium large Large)}
  validates :palette_id, presence: true

  extend ButtonCreator
  include ButtonUpdater

  def color
    button_color.value
  end

  def div_id
    "buttonId_#{id}"
  end
  
  SIZE = {
    'small' => 1,
    'medium' => 2,
    'large' => 4
  }

  def hash_params
    { title: title,
      speech_phrase: speech_phrase,
      speech_speed_rate: speech_speed_rate,
      button_color_id: button_color_id,
      size: size,
      user_id: user_id
    }
  end

  def self.default_button_params(user)
    { title: "I'm a button",
      speech_phrase: "This is what I say",
      speech_speed_rate: 0.2,
      button_color_id: ButtonColor.find_by_name('Turquoise').id,
      size: "Medium",
      user_id: user.id
    }
  end
  
  def ensure_position
    last_button = palette.buttons.last
    unless last_button
      self.row, self.col = 1, 1
      return
    end

    if last_button
      curr_button_col = last_button.col + SIZE[last_button.size.downcase]
      
      if can_fit_in_current_row?(last_button)
        self.row = last_button.row
        self.col = curr_button_col        
      else
        self.row = last_button.row + 1
        self.col = 1
      end
    end
  end

  private
  def can_fit_in_current_row?(last_button)
    curr_button_col = last_button.col + SIZE[last_button.size.downcase]
    curr_button_size = SIZE[self.size.downcase]
    curr_button_col <= 12 && (curr_button_col + curr_button_size) <= 13
  end
end
