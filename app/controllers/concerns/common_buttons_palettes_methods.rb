module CommonButtonsPalettesMethods
  def set_palette_buttons_values(speech_speed_rate, button_color, size)
    session_hash = {}
    session_hash[:palette_speech_speed_rate] = speech_speed_rate
    session_hash[:palette_button_color]      = button_color
    session_hash[:palette_size]              = size
    puts session_hash.inspect
    session_hash
  end
end
