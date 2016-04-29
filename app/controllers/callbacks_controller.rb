class CallbacksController < Devise::OmniauthCallbacksController
  require 'openid_connect_client'
  skip_before_action :verify_authenticity_token
  
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
  
  def baid_login
      if not persona_signed_in?
          oidc = get_client()
          oidc.authorize()
          
          session[:state] = oidc.state
          redirect_to(oidc.auth_endpoint)
      else
          redirect_to root_path
      end
  end
    
  def baid_callback
      if not persona_signed_in?
          oidc = get_client(request.parameters)
          oidc.authenticate()
          
          email = oidc.get('email')
          given_name = oidc.get('given_name')
          address = oidc.get('address')
          family_name = oidc.get('family_name')
          
          @persona = Persona.find_by(:email => email)
          
          if not @persona
             @persona = Persona.new
             @persona.nombre = given_name
             @persona.apellido = family_name
             @persona.email = email
             @persona.password = Devise.friendly_token.first(8)
             @persona.save
          end
          
          sign_in @persona
      end
      
      redirect_to root_path
  end
  
  def get_client(params = nil)
      oidc = ::OpenIDConnectClient::Client.new('https://id.buenosaires.gob.ar/openid', '81577894', '48f25ce70418480ca688668780be0ce1')
      oidc.redirect_url = 'http://192.168.220.68/expresometro/baid/callback'
      oidc.scopes = 'openid email profile address phone'
      
      oidc.state = session[:state]
      oidc.params = params if params
      
      oidc
  end

  def failure
      set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
      redirect_to root_path
  end
end