require './config/environment'

class UserController < ApplicationController #can either inherit from SinatraBase or AppContr since AppContr inherits from SinBase

   get '/signup' do #/users/new
        erb :"users/signup"
   end

   post '/signup' do #/users
        user = User.new(params[:user])
        if user.username.empty? || user.password.empty?
            @error = "Username and/or password can not be blank. Please enter a valid username and password."
            erb :"users/signup"
        else
            user.save
            redirect "/users/#{user.username}"
        end
        
   end
end
