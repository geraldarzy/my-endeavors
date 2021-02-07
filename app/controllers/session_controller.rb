class SessionsController < ApplicationController
    #users login
    get '/login' do
        #session.clear      #logs you out when u try to log in again(implement this into header)
        erb :"users/login"
    end

    post '/login' do
       # puts params
       # puts params[:user]
       # puts params[:user][:username]
       if params[:user][:username].empty? || params[:user][:password].blank?
            @error = "Username and/or password can not be blank. Please enter a valid username and password."
            erb :"users/login"
       else
            if  user = User.find_by(username: params[:user][:username])
                if user.authenticate(params[:user][:password])
                    session[:id] = user.id
                    redirect "/users/#{user.username}"
                else
                    @error = "Incorrect password, please try again."
                    erb :"users/login"
                end
            else
                @error = "Account not found, please try again."
                erb :"users/login"
            end
        end
    end

    #users logout
end