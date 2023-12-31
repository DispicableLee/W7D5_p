class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save!
            login(@user)
            redirect_to users_url
        else
            flash.now[:errors] = @user.errors.full_messages
            @user = User.new(user_params)
        end
    end

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def edit
        @user = User.find(params[:id])
        render :edit
    end





    private
    def user_params
        params.require(:user).permit(:username, :password)
    end

end
