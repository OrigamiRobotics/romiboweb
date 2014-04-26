module PalettesControllerUpdaters
  extend ActiveSupport::Concern

  def update_applicable_palette
    if params[:mode].present? &&
        params[:mode] == "multiple"
      handle_selections
    else
      @palette.update_attributes(palette_params)
    end
  end


  def update_all_buttons_selected
    (@palette.just_selected_all_buttons?) ?
        @palette.update_attributes(all_buttons_selected: true) :
        @palette.update_attributes(all_buttons_selected: false)
  end

end
