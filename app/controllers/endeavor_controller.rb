class EndeavorController < ApplicationController
    get "/famous-endeavors" do
        #show famous endeavors
        #add button to add to user.endeavors
    end

    #CREATE
    get "/users/:username/endeavors/new" do
        @user = Helper.current_user(session)
        if Helper.rightuser?(params,session) #checks to see if URLparams username matches session username by == for id
            erb :"endeavors/new"
        else
            erb :error
        end
    end
    #ADD A BOOLEAN FOR NEW COLUMN IN ENDEAVORS for COMPLETED endeavors
    post "/users/:username/endeavors" do
        @user = Helper.current_user(session)
        if Helper.rightuser?(params,session) #if the user matches check the if params is blank
            if params[:endeavor][:title].blank? || params[:endeavor][:description].blank?
                @error = "This endeavor must have a tile and description. Do not leave it blank."
                erb :"endeavors/new"
            else
                @endeavor = Endeavor.create(params[:endeavor])
                @user.endeavors << @endeavor
                redirect "/users/#{@user.username}/endeavors/#{@endeavor.id}"
            end
        else
            erb :error
        end
    end

    #READ
    #list all users existing endeavors
    get "/users/:username/endeavors" do
        if Helper.rightuser?(params,session)
            @user = Helper.current_user(session)
            @endeavors = @user.endeavors
            if @endeavors.empty?
                erb :"endeavors/empty_endeavors"
            else
                erb :"endeavors/endeavors_home"
            end
        else
            erb :error
        end
    end

    #show specific endeavor
    get "/users/:username/endeavors/:endeavor_id" do
        if Helper.rightuser?(params,session) #checks to see if user is logged in and right user
            @user = Helper.current_user(session)
            @endeavor = Endeavor.find(params[:endeavor_id])
            @users_endeavors = @user.endeavors
            erb :"endeavors/show"
        else
            erb :error
        end
    end

    #UPDATE
    get "/users/:username/endeavors/:endeavor_id/edit" do
        #edit form
        if Helper.rightuser?(params,session)
            @user = Helper.current_user(session)
            @endeavor = Endeavor.find(params[:endeavor_id])
            erb :"endeavors/edit"
        end

    end

    patch "/users/:username/endeavors/:endeavor_id" do
        if Helper.rightuser?(params,session)
            @user = Helper.current_user(session)
            @endeavor = Endeavor.find(params[:endeavor_id])
            @endeavor.title = params[:endeavor][:title]
            @endeavor.description = params[:endeavor][:description]
            @endeavor.save
            redirect "/users/#{@user.username}/endeavors/#{@endeavor.id}"
        end
    end


    #DELETE
    delete "/users/:username/endeavors/:endeavor_id" do
        if Helper.rightuser?(params,session)
            @user = Helper.current_user(session)
            @endeavor = Endeavor.find(params[:endeavor_id])
            @endeavor.delete
            redirect "/users/#{@user.username}/endeavors"
        else
            erb :error
        end
    end
end