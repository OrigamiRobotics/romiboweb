class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    super
  end


end