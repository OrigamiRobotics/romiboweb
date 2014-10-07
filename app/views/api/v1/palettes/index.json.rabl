collection @palettes, root: 'palettes'
attributes :id, :title, :color, :description, :owner_id
child :buttons do
  attributes :id, :palette_id, :title, :speech_phrase, :speech_speed_rate, :color, :size, :row, :col
end
