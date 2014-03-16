class ChangeColumnForButtons < ActiveRecord::Migration
  def change
    change_column :buttons, :speech_speed_rate, :integer
  end
end
