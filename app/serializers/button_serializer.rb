class ButtonSerializer < ActiveModel::Serializer
  self.root = false
  attributes :buttonTitle, :speechPhrase, :speechSpeedRate
  
  def buttonTitle
    object.title
  end
  
  def speechPhrase
    object.speech_phrase 
  end
  
  def speechSpeedRate
    object.speech_speed_rate
  end
end
