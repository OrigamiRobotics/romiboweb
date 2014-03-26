# RESTful API for User Registration. To be used by iPad app or other 3rd party client.
#

class Api::V1::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  respond_to :json

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  #
  # * *Args*    :
  #   - +sign_up_params+ -> ?
  # * *Returns* :
  #   - the User
  # * *Raises* :
  #   - +ArgumentError+ -> if any value is nil or negative
  #
  def create
    build_resource(sign_up_params)
    if resource.save
      #@user = resource
      #respond_with @user
      render json: resource.to_json(
          only: [:first_name, :last_name, :email, :auth_token]), status: :created
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end


end