class Palettes::ShareController < ApplicationController
  respond_to :html, :js
  def new
    @palette = Palette.find params[:palette_id]
    respond_with @palette
  end

  def create
    begin
      @email_sent = false
      @palette = Palette.find params[:palette_id]
      email = params[:email]
      if email.blank?
        @email_error_text = 'Please provide a valid email'
        return
      end
      PaletteMailer.share(@palette, email).deliver
      flash[:success] = "We have sent #{@palette.title} to #{email}. Thank you!"
      @email_sent = true  
    rescue
      Rails.logger.error "Email could not be sent: [#$!]"
      @email_error_text = 'Email could not be sent. Please try again in a few minutes.'
    end
  end
end
