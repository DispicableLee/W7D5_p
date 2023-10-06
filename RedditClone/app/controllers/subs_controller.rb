class SubsController < ApplicationController
    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator = current_user
        if @sub.save
            redirect_to user_url(@sub.moderator)
        else
            flash.now[:errors] = @sub.errors.full_messages
        end
    end

    def index 
        @subs = Sub.all
        render :index
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def edit
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub
        
    end


    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
