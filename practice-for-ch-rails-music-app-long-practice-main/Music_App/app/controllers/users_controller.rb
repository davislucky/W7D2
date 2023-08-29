class UsersController < ApplicationController
    before_action :require_logged_out

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to user_url
        else
            flash.now[:errors] = ["Cannot find a user with that email or password"]
            render :new
    end

    def show
        @user = User.find_by(params[:email])
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
