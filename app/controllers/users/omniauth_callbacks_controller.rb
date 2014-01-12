class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_linkedin_omniauth(request.env["omniauth.auth"], request.location)
    if user.persisted?
      flash.notice = "Signed in!"
      if user.sign_in_count == 0
        # UserMailer.delay.welcome_email(user) # .delay_for(1.day)
        user.update_linkedin_image
        # # user.update_linkedin_education
        # # user.update_linkedin_companies
      end
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
end