class CallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
 
  def open_id
    @persona = Persona.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @persona
  end
  
  def failure
    set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to root_path
  end
end