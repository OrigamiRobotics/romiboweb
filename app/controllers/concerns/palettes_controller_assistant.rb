module PalettesControllerAssistant
  extend ActiveSupport::Concern

  def delete_buttons
    @user.set_last_viewed_palette @palette
    @palette.update_attributes(last_viewed_button: nil)
    @palette.delete_buttons
    @button = @palette.current_button
  end

  def select_all_buttons
    set_all_buttons_selected true
  end

  def deselect_all_buttons
    set_all_buttons_selected false
  end

  def set_all_buttons_selected(make_selected)
    @palette.update_attributes(all_buttons_selected: make_selected)
    @palette.buttons.update_all({selected: make_selected})
  end

  def set_params
    @title = 'Palette Editor'
    @palette = Palette.new
    @palettes = @user.palettes
    if @palettes.present?
      @current_palette = @user.current_palette
      gon.active_palette = @current_palette.id
    end
  end

  def set_user
    if params[:palette_user_id].present? || session[:palette_user_id].present?
      user_id = (params[:palette_user_id].present?) ? params[:palette_user_id].to_i : session[:palette_user_id].to_i
      @user = User.find(user_id)
      session[:palette_user_id] = params[:palette_user_id]
    else
      @user = current_user
      session[:palette_user_id] = nil
    end
  end

  def applicable_method
    {:all       => method(:select_all_buttons),
     :none      => method(:deselect_all_buttons),
     :updating  => method(:handle_multiple_edits),
     :singular  => method(:handle_singular_selections)
    }
  end

  def palette_owner
    set_user
    @palette = @user.palettes.find_by_id(params[:id])
    redirect_to(palettes_path) if @palette.nil?
  end
end
