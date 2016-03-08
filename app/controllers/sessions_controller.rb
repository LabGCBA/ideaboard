class SessionsController < ApplicationController
  def new
    # spits out a login form to start session
  end
 
  def create
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        # FIXME - needs normalizing before
        # checking for the identity_url
        unless user = User.find_by_identity_url(identity_url)
          user = User.create(identity_url: identity_url)
        end
        sign_in user
      else
        render 'new'
      end
    end
  end
 
  def destroy
    logout
    redirect_to root_url
  end
end