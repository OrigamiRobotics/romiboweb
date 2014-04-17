collection @palettes, root: 'palettes'
attributes :id, :title, :color, :description
child :buttons do
  attributes :id, :title, :speech_phrase, :speech_speed_rate, :color, :size, :row, :col
end
