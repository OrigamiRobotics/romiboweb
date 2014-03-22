class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.encrypt_id

    handle_twitter_auth resource

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_flash_message :notice, resource.errors.full_messages.uniq.split.join( ", ").to_s
      redirect_to root_path
    end
  end

  def after_inactive_sign_up_path_for(resource)
    if resource.confirmed_at.present?
      dashboard_path
    else
      unconfirmed_path(index: resource)
    end
  end

  private

  def handle_twitter_auth(resource)
    if resource.provider == 'twitter' && resource.email.present? && resource.uid.present?
      resource.confirmed_at = Time.now
    end

  end
end
