class RomibowebPagesController < ApplicationController
  before_action :set_gon

  def home
    if user_signed_in?
      redirect_to dashboard_path
    else
      @title = 'Home'
    end
  end

  def editor
    @title = 'Palette Editor'
    @palette = Palette.new
  end

  def terms
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

end
