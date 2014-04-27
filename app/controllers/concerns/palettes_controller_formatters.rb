module PalettesControllerFormatters
  extend ActiveSupport::Concern

  def respond_to_format_for(format)
    format.html {redirect_to palettes_path}
    format.json { render json: @palette }
    format.js
  end

  def handle_format_for_invalid_input(format)
    flash[:alert] = 'Invalid Input'
    format.js
    format.html { render :action  => :edit }
    format.json { render nothing: true }
  end

  def respond_to_format_for_show
    if @palette
      respond_to do |format|
        respond_to_format_for format
      end
    end
  end
end

