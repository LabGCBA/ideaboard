class BaidController < ApplicationController
    def login()
        oidc = OpenIDConnectClient::Client.new('https://id.buenosaires.gob.ar/openid', '81577894', '48f25ce70418480ca688668780be0ce1')
        oidc.redirect_url = "http://192.168.220.68/expresometro/baid/callback"
        oidc.scopes = "openid email profile address phone"

        oidc.authorize()

        session[:state] = oidc.state
        redirect_to(oidc.auth_endpoint)
    end
    
    def callback()
        oidc = OpenIDConnectClient::Client.new('https://id.buenosaires.gob.ar/openid', '81577894', '48f25ce70418480ca688668780be0ce1')
        oidc.redirect_url = "http://192.168.220.68/expresometro/baid/callback"
        oidc.scopes = "openid email profile address phone"
        oidc.state = session[:state]
        oidc.params = params
        
        puts params.inspect
        puts oidc.state.inspect
        
        oidc.authenticate()
        
        @email = oidc.get('email')
        @given_name = oidc.get('given_name')
        @address = oidc.get('address')
    end
end
