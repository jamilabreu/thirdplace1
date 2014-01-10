class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_linkedin_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      if user.sign_in_count == 0
        user.update_linkedin_image
        if community = Community.find_by(id: params[:community])
          user.communities << community
        end
        # user.update_linkedin_education
        # user.update_linkedin_companies
      end
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
end