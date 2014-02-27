class Api::V1::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  respond_to :json

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