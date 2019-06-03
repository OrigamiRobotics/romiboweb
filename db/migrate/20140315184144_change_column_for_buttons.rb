class ChangeColumnForButtons < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :buttons do |t|
        dir.up {t.change :speech_speed_rate, :float}
        dir.down {t.change :speech_speed_rate, :integer}
      end
    end
  end
end
