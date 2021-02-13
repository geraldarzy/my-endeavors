class EndeavorController < ApplicationController
    get "/famous-endeavors" do
        #show famous endeavors
        #add button to add to user.endeavors
    end

    #CREATE
    get "/users/:username/endeavors/new" do
        @user = Helper.current_user(session)    #assigns user var the current user
        if Helper.rightuser?(params,session)    #checks to see if URLparams username matches session username by =='ing for id
            erb :"endeavors/new"
        else
            erb :error
        end
    end
    #ADD A BOOLEAN FOR NEW COLUMN IN ENDEAVORS for COMPLETED endeavors
    post "/users/:username/endeavors" do
        @user = Helper.current_user(session)
        if Helper.rightuser?(params,session)                                                            #first check if user is who he says he is. Who he is = Session[id] & Who he says he is = params
            if params[:endeavor][:title].blank? || params[:endeavor][:description].blank?               #if user leaves title of desc fields blank
                @error = "This endeavor must have a tile and description. Do not leave it blank."
                erb :"endeavors/new"
            elsif params[:endeavor][:pic] == ""                                                         #if user leaves pic field blank
                params[:endeavor][:pic] = nil                                                           #assign params[pic](endeavor.pic) to nil
                @endeavor = Endeavor.create(params[:endeavor])                                          #creates and saves new endeavor based on params
                @user.endeavors << @endeavor                                                            #associates current_user to new endeavor
                redirect "/users/#{@user.username}/endeavors/#{@endeavor.id}"                           #redirect to show specific
            elsif !params[:endeavor][:pic].match("dl=0")                                                #if link does not have dl=0 in it, reject link, this is because the way the picture works, we can only display links from dropbox 
                @error = "Image link invalid.<br>Link must be a dropbox image link.<br>Try the 'Share with Dropbox link'."          #error message that gets displayed on the erb
                erb :"endeavors/new"                    
            else                                                                                        #if user gets past all that^ that means they did everything correctly.
                params[:endeavor][:pic] = params[:endeavor][:pic].gsub(/dl=0/, "raw=1")                 #this is where we chop off the dl=0 and change it to raw=1 so that img tag undertands the picture
                @endeavor = Endeavor.create(params[:endeavor])                                          #because dl=0 sends you to dropbox website with picture displayed on site, raw=1 sends you to just raw picture
                @user.endeavors << @endeavor                                                            #associates user and endeavor
                redirect "/users/#{@user.username}/endeavors/#{@endeavor.id}"                           
            end
        else
            erb :error                                                                                  #if fails first conditional if statement(user not who he says he is) load error views
        end
    end

    #READ (CrUD)
    #list all users existing endeavors
    get "/users/:username/endeavors" do                                                                 
        if Helper.rightuser?(params,session)                                #uses Helper to check if user is right user. By matching params id against session id
            @done_count = 0                                                 #counts completed endeavors to know which lists to display in erb
            @user = Helper.current_user(session)                            #sets user var to current user
            @endeavors = @user.endeavors                                    #sets endeavor isntance var to list of users endeavors for erb to work with
            if @endeavors.empty?                                            #if user has no endeavors, load empty erb view
                erb :"endeavors/empty_endeavors"                            
            else
                erb :"endeavors/endeavors_home"                             #if not empty load regular erb view
            end
        else
            erb :error                                                      #if not the Helper.rightuser? load error view
        end
    end

    #show specific endeavor
    get "/users/:username/endeavors/:endeavor_id" do
        if Helper.rightuser?(params,session)                        #checks to see if user is logged in and right user
            @user = Helper.current_user(session)                    
            @endeavor = Endeavor.find(params[:endeavor_id])         #gets endeavor id through url params
            @users_endeavors = @user.endeavors                      #user = current user | endeavor = specific endeavor | user_endeavors = users list of endeavors
            erb :"endeavors/show"                                   #loads the show specific erb
        else
            erb :error
        end
    end

    #UPDATE (CRuD)
    get "/users/:username/endeavors/:endeavor_id/edit" do
        #edit form
        if Helper.rightuser?(params,session)                        #checks if right user
            @user = Helper.current_user(session)                    #assigns vars for erb to use
            @endeavor = Endeavor.find(params[:endeavor_id])
            @endeavor_pic = @endeavor.pic.gsub(/raw=1/, "dl=0")
            binding.pry                 #ALWAYS use @endeavor_pic to set value of text-box for dl=0 to be later turned into raw=1 again
            erb :"endeavors/edit"                           
        end

    end

    patch "/users/:username/endeavors/:endeavor_id" do
        if Helper.rightuser?(params,session)
            @user = Helper.current_user(session)                        #gets current user and endeavor first
            @endeavor = Endeavor.find(params[:endeavor_id])
            @endeavor.title = params[:endeavor][:title]                 #re-initializes each attribute of endeavor to params
            @endeavor.description = params[:endeavor][:description]
            @endeavor.pic = params[:endeavor][:pic]
            @endeavor.pic_caption =params[:endeavor][:pic_caption]
            @endeavor.status = params[:endeavor][:status]
            
            if params[:endeavor][:title].blank? || params[:endeavor][:description].blank?           #if either title or desc field blank, error
                @error = "This endeavor must have a tile and description. Do not leave it blank."
                erb :"endeavors/edit"
            elsif @endeavor.pic == ""                                                               #if pic field blank, set pic to nil
                @endeavor.pic = nil
                @endeavor.save                                                                      #saves all the re-initialization that was done earlier also saving the nil pic attr
                redirect "/users/#{@user.username}/endeavors/#{@endeavor.id}"
            elsif !params[:endeavor][:pic].match("dl=0")                                            
                @error = "Image link invalid.<br>Link must be a dropbox image link.<br>Try the 'Share with Dropbox link."
                erb :"endeavors/edit"
            else
                @endeavor.pic = params[:endeavor][:pic].gsub(/dl=0/, "raw=1")             #if link does not have dl=0 in it, reject link, this is because the way the picture works, we can only display links from dropbox  
                @endeavor.save                                                                      #saves all the re-initialization that was done earlier
                redirect "/users/#{@user.username}/endeavors/#{@endeavor.id}"
            end
        end
    end


    #DELETE
    delete "/users/:username/endeavors/:endeavor_id" do
        if Helper.rightuser?(params,session)                    #most importantly, checks to see if user has rights to this route
            @user = Helper.current_user(session)                
            @endeavor = Endeavor.find(params[:endeavor_id])     #finds the right endeavor based off params[id]
            @endeavor.delete                                    #deletes the endeavor
            redirect "/users/#{@user.username}/endeavors"
        else
            erb :error                                          #error if not the right user
        end
    end
end