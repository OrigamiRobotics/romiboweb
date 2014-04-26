module ButtonUpdater

  def update_parent_palette
    self.palette.last_viewed_button = try(:id)
    self.palette.save
  end

  def set_selection(params)
    if params[:mode].present? && params[:mode] == 'multiple'
      self.selected = self.selected? ? false : true
      save
      palette.all_buttons_selected = palette.just_selected_all_buttons? ? true : false
    end
  end
end
