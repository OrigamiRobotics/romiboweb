class Palettes::ShareController < ApplicationController
  respond_to :html, :js
  def new
    @palette = Palette.find params[:palette_id]
    respond_with @palette
  end

  def create
    begin
      @palette = Palette.find params[:palette_id]
      email = params[:email]
      PaletteMailer.share(@palette, email).deliver
      flash[:success] = "We have sent #{@palette.title} to #{email}. Thank you!"
    rescue
        #=> TODO: handle exception here
    end
  end
end
