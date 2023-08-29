class SessionsController < ApplicationController
    # before_action :require_logged_in, only: [:destroy]
    # before_action :require_logged_out, only: [:create, :new]

    def new
        render :new
    end 

    def create
        user = User.find_user_by_credentials(params[:user][:email], params[:user][:password])

        if user.nil?
            flash.now[:errors] = ["Could not find user with that username or password"]
            render :new
        else
            login!(user)
            redirect_to user_url(user)
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end
