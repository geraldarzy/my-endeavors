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
        if user.password.blank? || user.username.empty? #checks if input is valid
            @error = "Username and/or password can not be blank. Please enter a valid username and password."
            erb :"users/signup"
        elsif User.find_by(username: user.username)     # checks if username is taken
            @error = "Username is already taken, please choose a different username."
            erb :"users/signup"
        else
            user.save                                   #finally saves user if passes all tests
            session[:id] = user.id                      #user.id is set to a non-stateless variable
            redirect "/users/#{user.username}"          #redirects to home page customed to user
        end
        
    end
end
