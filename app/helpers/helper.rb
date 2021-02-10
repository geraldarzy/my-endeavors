class Helper
    def self.current_user(session_hash)
        User.find(session_hash[:id])
    end
    def self.is_logged_in?(session_hash)
        !!session_hash[:id]                 #double '!' makes the statement return a boolean
    end
    def self.rightuser?(params,session) #makes sure URLparams and session are same people (params input HAS to be params[:username])
        if self.is_logged_in?(session)
            User.find_by(username: params[:username]) == User.find(session[:id])
        end
    end #checks to see if URLparams username matches session username by == for id
end