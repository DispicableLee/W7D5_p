class SessionsController < ApplicationController
    def new
        # debugger
        @user = User.new
        render :new
    end

    def create
        # debugger
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login(@user)
            redirect_to users_url
        else
            flash.now[:errors] = @user.errors.full
            @user = User.new(username: params[:user][:username])
            render :new
        end
    end


    def destroy
        logout
        redirect_to new_session_url
    end

end
