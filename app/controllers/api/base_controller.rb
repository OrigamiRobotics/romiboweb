class Api::BaseController < ApplicationController
  before_filter :authenticate_token!
  protect_from_forgery with: :null_session
  respond_to :json

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