class RomiboAuthFailure < Devise::FailureApp

  def redirect_url
    root_path
  end

  def respond
    if http_auth?
      false
    else
      redirect
    end
  end
end