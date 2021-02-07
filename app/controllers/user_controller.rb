require './config/environment'

class UserController < ApplicationController #can either inherit from SinatraBase or AppContr since AppContr inherits from SinBase
    configure do
        enable :sessions
        set :session_secret, "secret"
    end

   get '/signup' do #/users/new
        erb :"users/signup"
   end

   post '/signup' do #/users
        user = User.new(params[:user])
        if user.password.blank? || user.username.empty?
            @error = "Username and/or password can not be blank. Please enter a valid username and password."
            erb :"users/signup"
        else
            user.save
            session[:id] = user.id
            redirect "/users/#{user.username}"
        end
        
   end
end
