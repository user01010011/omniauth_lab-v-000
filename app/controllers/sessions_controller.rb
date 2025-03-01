class SessionsController < ApplicationController
  # This is required because of a quirk the "developer" authentication
  # strategy. We'll remove this when we move to a "real" provider.
  # skip_before_action :verify_authenticity_token, only: :create

  # def create
  #   # After entering a name and email value in the /auth/developer
  #   # path and submitting the form, you will see a pretty-print of
  #   # the authentication data object that comes from the "developer"
  #   # strategy. In production, we'll swap this strategy for something
  #   # like 'github' or 'facebook' or some other authentication broker
  #   pp request.env['omniauth.auth']

  #   # We're going to save the authentication information in the session
  #   # for demonstration purposes. We want to keep this data somewhere so that,
  #   # after redirect, we have access to the returned data
  #   session[:name] = request.env['omniauth.auth']['info']['name']
  #   session[:omniauth_data] = request.env['omniauth.auth']

  #   # Ye olde redirect
  #   redirect_to root_path
  # end
  
  def new
  end 

  def create 
    user = User.find_or_create_by(:uid => auth['uid']) do |user|
      user.name = auth['info']['name']
    end
    session[:user_id] = user.try(:id)
    render 'welcome/home'
  end

  private 

  def auth 
    request.env['omniauth.auth']
  end 
end
