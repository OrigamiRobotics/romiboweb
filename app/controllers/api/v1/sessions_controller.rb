# RESTful API for Session Management.
#

class Api::V1::SessionsController < Devise::SessionsController
  before_filter :authenticate_token!, except: :create
  protect_from_forgery with: :null_session
  respond_to :json

  # Authorize user and create session if valid.
  # If email or password is invalid, returns AuthorizationError.
  #
  # * *Args*    :
  #   - +email+ -> email belonging to registered User
  #   - +password+ -> password belonging to registered User
  # * *Returns* :
  #   - the User
  # * *Raises* :
  #   - +ArgumentError+ -> if any value is nil or negative
  #   - +AuthorizationError+ -> if user or password is incorrect
  #
  def create
    unless params[:user]
      head :unauthorized and return
    end
    user = User.find_for_database_authentication email: params[:user][:email]
    head :unauthorized and return unless user

    if user.valid_password? params[:user][:password]
      user.reset_auth_token!
      render json: user.to_json(
          only: [:first_name, :last_name, :email, :auth_token]),
             status: :created
    else
      head :unauthorized and return
    end
  end

  # Clear session for current user.
  def destroy
    @current_user.reset_auth_token!
    head :no_content # return http status code 204
  end


  protected
  def authenticate_token!
    # Possible replay attack vulnerability
    if user = authenticate_with_http_token { |token, options|
      User.find_by_auth_token token
    }
      @current_user = user
    else
      request_http_token_authentication
    end
  end


end
