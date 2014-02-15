class RomibowebPagesController < ApplicationController
  before_filter :set_gon

  def home
    @title = 'Home'
  end

  def editor
    @title = 'Palette Editor'
  end

end
