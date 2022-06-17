class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def new
    render "new"
  end
 
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      if user.role_id == 2
        redirect_to restaurants_path
      elsif user.role_id == 3
        redirect_to '/users/{user.id}'
      elsif user.role_id == 4
        redirect_to users_path
      else
        redirect_to '/'
      end
    else
      flash[:error] = "Your login attempt was in valid. Please try again."
      redirect_to new_session_path
    end
  end

  def destroy
    # if current_user.role_id != 4
      session[:current_user_id] = nil
      @current_user = nil
      redirect_to "/"
    # end
  end
  
end
 

