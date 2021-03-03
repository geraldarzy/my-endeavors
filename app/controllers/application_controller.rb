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


  helpers do 
    #helper methods go here so that they're inherited by other controllers and also accessible in views
    def authorized?
      Endeavor.find_by(id:params[:endeavor_id]).user.id == session[:id]
    end
    def redirect_to_index_if_not_authorized
      if !authorized? 
        redirect "/users/#{current_user.username}/endeavors"
      end
    end
    def right_url_user?
      !!(User.find_by(username:params[:username]).id == current_user.id)
    end
    def redirect_if_not_right_url_user
      if !right_url_user?
        redirect "/"
      end
    end
    def logged_in?
      !!(session[:id])
    end
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login"
      end
    end

    def current_user
      User.find_by(id: session[:id])
    end
  end

end
