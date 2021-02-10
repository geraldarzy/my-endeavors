class SessionsController < ApplicationController
    #users login
    get '/login' do
        session.clear           #logs user out if user tries to access log in page while logged in
        erb :"users/login"      #alt solution: redirect if Helper.logged in
    end

    post '/login' do
       # puts params
       # puts params[:user]
       # puts params[:user][:username]
       if params[:user][:username].empty? || params[:user][:password].blank?        #if username or password fields are blannk show error
            @error = "Username and/or password can not be blank. Please enter a valid username and password."
            erb :"users/login"
       else                                                                         #if username and password are filled in
            if  user = User.find_by(username: params[:user][:username])             #finds the user you claim to be through params username
                if user.authenticate(params[:user][:password])                      #matches the password of who you claim to be against the password you provided
                    session[:id] = user.id                                          #if you match, logs you in by setting a session id to the id your account has
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
    get "/logout" do                    #log out just clears the session because 'logged in' just means that ur session has an id attribute
        session.clear
        redirect "/"
    end
end