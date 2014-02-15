module ApplicationHelper

  #generates a full tile
  #it prepends 'Romibo | ' to the supplied string
  def full_title
    (@title.nil?) ? "#{Romiboweb}" : "#{Romiboweb} | #{@title}"
  end
end
