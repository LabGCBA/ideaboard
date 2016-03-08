include SessionsHelper
# openid tutorial https://thirstyforcola.wordpress.com/2013/06/30/setting-up-openid-on-rails/

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
end
