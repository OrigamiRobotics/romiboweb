# == Schema Information
#
# Table name: palettes
#
#  id                   :bigint           not null, primary key
#  title                :string
#  description          :string
#  color                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  owner_id             :integer
#  system               :boolean          default(FALSE)
#  last_viewed_button   :integer
#  all_buttons_selected :boolean          default(FALSE)
#

class PaletteSerializer < ActiveModel::Serializer
  self.root = false
  attributes :name
  has_many :buttons, key: :actions
  
  def name
    object.title
  end
end
