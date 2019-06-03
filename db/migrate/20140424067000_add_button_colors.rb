class AddButtonColors < ActiveRecord::Migration[5.2]
  def change
      colors = [
          { name: 'Red',         value: '#c1392d' },
          { name: 'Orange',      value: '#d45300' },
          { name: 'Yellow',      value: '#f39b13' },
          { name: 'Light Green', value: '#2dcc70' },
          { name: 'Green',       value: '#27ae61' },
          { name: 'Turquoise',   value: '#13c8b0' },
          { name: 'Blue',        value: '#3498db' },
          { name: 'Purple',      value: '#8d44af' },
          { name: 'Pink',        value: '#fe7a7a' }
      ]
      colors = colors.map { | color | "'#{color[:name]}', '#{color[:value]}', NOW(), NOW()" }.join("), (")
      execute "INSERT INTO button_colors (name, value, created_at, updated_at) VALUES (#{colors});"
  end
end
