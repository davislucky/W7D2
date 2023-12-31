class UsersController < ApplicationController
    # before_action :require_logged_out, only: [:create, :new]

    def new
        @user = User.new
    end

    def index
        render :index
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
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
