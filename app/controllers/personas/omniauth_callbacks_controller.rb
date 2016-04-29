class Personas::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  
  def openid_connect
      dict = {uid: request.env['omniauth.uid'], provider: request.env['omniauth.provider']}
      dict_obj = OpenStruct.new dict

      Rails.logger.debug("debug:: REQUEST.ENV " + request.env.inspect)
      @persona = Persona.from_omniauth(dict_obj)

      if @persona.persisted?
          sign_in_and_redirect(@persona, event: :authentication)
          set_flash_message(:notice, :success, kind: "BAid") if is_navigational_format?
      else
          session['devise.baid_data'] = request.env['omniauth.state']
          redirect_to new_user_registration_url
      end
  end
  
  def openid_connect_strategy
      dict = {uid: request.env['omniauth.uid'], provider: request.env['omniauth.provider']}
      dict_obj = OpenStruct.new dict

      Rails.logger.debug("debug:: REQUEST.ENV " + request.env.inspect)
      @persona = Persona.from_omniauth(dict_obj)

      if @persona.persisted?
          sign_in_and_redirect(@persona, event: :authentication)
          set_flash_message(:notice, :success, kind: "BAid") if is_navigational_format?
      else
          session['devise.baid_data'] = request.env['omniauth.state']
          redirect_to new_user_registration_url
      end
  end

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
