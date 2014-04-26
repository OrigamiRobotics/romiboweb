class PaletteSerializer < ActiveModel::Serializer
  self.root = false
  attributes :name
  has_many :buttons, key: :actions
  
  def name
    object.title
  end
end
