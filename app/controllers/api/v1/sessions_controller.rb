class Api::V1::SessionsController < Devise::SessionsController
  before_filter :authenticate_token!, except: :create
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    user = User.find_for_database_authentication email: params[:email]
    head :unauthorized and return unless user

    if user.valid_password? params[:password]
      user.reset_auth_token!
      render json: user.to_json(
          only: [:first_name, :last_name, :email, :auth_token]),
             status: :created
    else
      head :unauthorized and return
    end
  end

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