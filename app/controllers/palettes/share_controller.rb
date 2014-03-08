class Palettes::ShareController < ApplicationController
  respond_to :html, :js
  def new
    @palette = Palette.find params[:palette_id]
    respond_with @palette
  end

  def create
    @palette = Palette.find params[:palette_id]
    flash[:success] = 'Email has been sent. Thank you!'
  end
end
