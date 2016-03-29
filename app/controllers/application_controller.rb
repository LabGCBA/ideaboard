# openid tutorial https://thirstyforcola.wordpress.com/2013/06/30/setting-up-openid-on-rails/

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  
  # if persona is logged in, return current_persona, else return guest_persona
  def current_or_guest_persona
    if current_persona
      if session[:guest_persona_id] && session[:guest_persona_id] != current_persona.id
        logging_in
        # reload guest_persona to prevent caching problems before destruction
        guest_persona(with_retry = false).reload.try(:destroy)
        session[:guest_persona_id] = nil
      end
      current_persona
    else
      guest_persona
    end
  end

  # find guest_persona object associated with the current session,
  # creating one as needed
  def guest_persona(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_persona ||= Persona.find(session[:guest_persona_id] ||= create_guest_persona.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_persona_id] invalid
     session[:guest_persona_id] = nil
     guest_persona if with_retry
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  # called (once) when the persona logs in, insert any code your application needs
  # to hand off from guest_persona to current_persona.
  # see http://blog.shivamdaryanani.com/blog/2013/11/21/create-a-guest-user-record-with-devise/
  def logging_in
    # For example:
    # guest_comments = guest_persona.comments.all
    # guest_comments.each do |comment|
      # comment.persona_id = current_persona.id
      # comment.save!
    # end
  end

  def create_guest_persona
    persona = Persona.create(nombre: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    persona.save!(:validate => false)
    session[:guest_persona_id] = persona.id
    persona
  end

end
