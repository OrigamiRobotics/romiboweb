object @palette
attributes :id, :title, :color, :description, :owner_id
child :buttons do
  attributes :id, :title, :speech_phrase, :speech_speed_rate, :color, :size, :row, :col
end

