class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def update
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :image, :remote_image_url)
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :email, :password, :image, :image_cache, :city_ids, :company_ids, :culture_ids,
        :degree_ids, :field_ids, :gender_ids, :interest_ids, :orientation_ids,
        :profession_ids, :relationship_ids, :religion_ids, :school_ids, :standing_ids,
        culture_ids: [], profession_ids: [], company_ids: [], field_ids: []
      )
    end
  end
end