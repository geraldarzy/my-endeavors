class EndeavorController < ApplicationController
    get "/famous-endeavors" do
        #show famous endeavors
        #add button to add to user.endeavors
    end

    #new
    get "/users/:username/endeavors/new" do
        redirect_if_not_right_url_user
        redirect_if_not_logged_in
        @endeavor = Endeavor.new
        erb :"endeavors/new"
    end
    #create
    post "/users/:username/endeavors" do
        redirect_if_not_logged_in
        @endeavor = current_user.endeavors.new(params[:endeavor])
        if @endeavor.save
            redirect "users/#{current_user.username}/endeavors/#{@endeavor.id}"
        else
            erb :"endeavors/new"
        end
        
    end

    #endeavors_index
    get "/users/:username/endeavors" do    
        redirect_if_not_logged_in
        redirect_if_not_right_url_user  #if logged into username:gerald, cant go to /users/bob/endeavors, even  tho /users/bob/endeavors will still show geralds endeavors
        @done_count = 0        #                   
        @endeavors = current_user.endeavors                                   
        if @endeavors.empty?
            erb :"endeavors/empty_endeavors"                            
        end
        erb :"endeavors/endeavors_home"
    end

    #show user's endeavor
    get "/users/:username/endeavors/:endeavor_id" do
        redirect_if_not_logged_in
        redirect_to_index_if_not_authorized
        redirect_if_not_right_url_user                  
        set_endeavor
        erb :"endeavors/show"                               

    end
    #edit
    get "/users/:username/endeavors/:endeavor_id/edit" do
        redirect_to_index_if_not_authorized
        set_endeavor
        erb :"endeavors/edit"                           
    end
    #update
    patch "/users/:username/endeavors/:endeavor_id" do
        set_endeavor
        check_status_before_update          #checks if params passed in status, if not, set it to nil
        if @endeavor.update(params[:endeavor])
            redirect "/users/#{current_user.username}/endeavors/#{@endeavor.id}"
        else
            erb :"endeavors/edit"
        end
    end
    #destroy
    delete "/users/:username/endeavors/:endeavor_id" do
        redirect_if_not_logged_in
        redirect_to_index_if_not_authorized              
        set_endeavor
        @endeavor.delete                                    
        redirect "/users/#{@user.username}/endeavors"
    end

    private 
    def set_endeavor
        @endeavor = Endeavor.find(params[:endeavor_id])
    end
    def check_status_before_update
        #checks if params passed in status, if not, set it to nil
        if !(params[:endeavor][:status])
            params[:endeavor][:status]=nil
        end
    end
end