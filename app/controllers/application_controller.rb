require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :home
  end

  #personalized users homepage
  get "/users/:username"do
    @user = Helper.current_user(session)
    erb :"users/home"
  end

end
