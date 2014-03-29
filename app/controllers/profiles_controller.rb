class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_gon, :get_profile


  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    respond_to do |format|
      if @profile.update_attributes(profile_params)
        handle_after_save format
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@profile) }
      end
    end
  end

  def show
  end

  private

  def handle_after_save(format)
    #if params[:profile].present? and params[:profile][:avatar].present?
    #  process_avatar format
    #else
      flash[:success] = 'Your profile was successfully updated.'
      format.html { redirect_to @profile}
      format.json { respond_with_bip(@profile) }
    #end
  end

  def process_avatar(format)
    format.html do
      gon.ratio = 1
      render :crop
    end
  end

  def get_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:user_name, :avatar,
                                    :crop_x, :crop_y, :crop_w, :crop_h
    )
  end

end