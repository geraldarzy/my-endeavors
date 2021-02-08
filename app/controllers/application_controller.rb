require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    session.clear
    erb :home
  end

  #personalized users homepage
  get "/users/:username"do
    @user = Helper.current_user(session)
    if @user == User.find_by(username: params[:username])
      erb :"users/user_home"
    else
      erb :error #leads you to error if you @user does not match params[:username]
    end
  end

end
