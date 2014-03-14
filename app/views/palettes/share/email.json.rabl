object @palette
attributes :title => :name
child :buttons, :root => :actions, :object_root => false do
  attributes :title => :buttonTitle,
             :speech_phrase => :speechPhrase,
             :speech_speed_rate => :speechSpeedRate
end
