collection @palettes, root: 'palettes'
attributes :id, :title, :color, :description
child :buttons do
  attributes :id, :title, :speech_phrase, :speech_speed_rate, :button_color_id, :size, :row, :col
end
