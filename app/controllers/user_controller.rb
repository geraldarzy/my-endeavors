require './config/environment'

class UserController < ApplicationController #can either inherit from SinatraBase or AppContr since AppContr inherits from SinBase
    configure do
        enable :sessions
        set :session_secret, "secret"
    end

   get '/signup' do #/users/new
        session.clear           #signs user out if they try to view sign up page while logged in
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
            user.endeavors << Endeavor.create(title: "My First Trip (Sample Text)", description: "Here you can write all about your trip and treat it as your journal. Years from now you can come back to this page and read all about how much fun you had when you, for example, went on that trip to Cancun! It was so fun, the weather was so nice and clear, the pina colada was so cold and refreshing, and my oh my the night life was crazy!", pic: "https://www.dropbox.com/s/7dye6k5opjrrl41/mexico-cancun-sun-party.jpg?raw=1", pic_caption:"You can also write a short caption about your picture!")
            user.endeavors << Endeavor.create(title: "My Second Trip (Sample Text)", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",pic:"https://www.dropbox.com/s/gf7u3mv4gx5kxno/flatiron-building-new-york-city_23-2148184365.jpg?raw=1", pic_caption:"This building has a cool name.")
            user.save                                   #finally saves user if passes all tests
            session[:id] = user.id                      #user.id is set to a non-stateless variable
            redirect "/users/#{user.username}"          #redirects to home page customed to user
        end
    end
end
