require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    session.clear               #logs user out when user re enters websites home
    erb :home                   #alt solution to this ^ if @Helper.logged_in do {erb:user_home} or redirect
  end

  #personalized users homepage
  get "/users/:username"do
    @endeavors = Endeavor.all
    @user = Helper.current_user(session)                        #gets current user by checking session id through helper class
    if @user == User.find_by(username: params[:username])       #FIX THIS potential problem where two diff users have same username
      erb :"users/user_home"                                    #shows the erb file    
    else
      erb :error                                                #leads you to error if you @user does not match params[:username]
    end
  end

end
