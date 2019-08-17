# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  def pocket
    authorization = Authorization.find_or_initialize_by(
      user_id: auth_params[:user_id],
      provider: 'pocket'
    )

    authorization.token = auth_info.credentials.token
    authorization.state = 'active'
    authorization.user_id = auth_params[:user_id]
    authorization.save!

    redirect_to "/airtable"
  end

  def goodreads
    authorization = Authorization.find_or_initialize_by(
      user_id: auth_params[:user_id],
      provider: 'goodreads'
    )

    authorization.key = auth_info.extra.access_token.consumer.key
    authorization.token = auth_info.credentials.token
    authorization.state = 'active'
    authorization.user_id = auth_params[:user_id]
    authorization.uid = auth_info.uid
    authorization.save!

    redirect_to "/airtable"
  end

  def auth_params
    request.env['omniauth.params'].with_indifferent_access
  end

  def auth_info
    request.env['omniauth.auth']
  end

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
