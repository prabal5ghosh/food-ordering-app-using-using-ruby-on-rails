class UsersController < ApplicationController
    skip_before_action :ensure_user_logged_in
    def new
        @user = User.new
        render "users/new"
    end

    def create
        @user= User.new(user_params)      
        if @user.save
            session[:current_user_id] = @user.id
            if @user.role_id == 2
                redirect_to restaurants_path
                # redirect_to session_path
            elsif @user.role_id == 3
                redirect_to new_user_path
                # redirect_to '/users/{@user.id}', allow_other_host: true
                # redirect_to '/'

            else
                # redirect_to restaurents_path 
            end
        else
            flash[:error]= @user.errors.full_messages.join(", ")
            redirect_to new_user_path	
        end
    end

    def show
        # @restaurant=Restaurant.find(params[:id])
        render '/users/appview'
    end

    private
    def user_params       
        params.require(:user).permit(:role_id, :first_name, :last_name, :email, :password )
    end
    
end