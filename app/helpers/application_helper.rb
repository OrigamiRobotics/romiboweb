module ApplicationHelper

  #generates a full tile
  #it prepends 'Romibo | ' to the supplied string
  def full_title(title = nil)
    if @title.present?
      (@title.nil?) ? "#{Romiboweb}" : "#{Romiboweb} | #{@title}"
    else
      (title.nil?) ? "#{Romiboweb}" : "#{Romiboweb} | #{title}"
    end
  end

  def profile_avatar_url(person, size = :thumb)
    if person.get_avatar_url(size).present?
      person.get_avatar_url size
    else
      email = (person.email.present?)? person.email : "fakeemail@email.com"
      gravatar_id = Digest::MD5::hexdigest(email.downcase)
      "https://secure.gravatar.com/avatar/#{gravatar_id}"
    end
  end
end
