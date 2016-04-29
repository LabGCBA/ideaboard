module OmniAuth
  module Strategies
    autoload :OpenIDConnectStrategy, Rails.root.join('lib', 'strategies', 'openid_connect') 
  end
end