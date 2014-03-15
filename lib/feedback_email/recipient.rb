module FeedbackEmail

  class Recipient < Struct.new(:short_name, :name, :email); end

end