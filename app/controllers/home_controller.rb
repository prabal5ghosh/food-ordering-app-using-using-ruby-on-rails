class HomeController < ApplicationController
    skip_before_action :ensure_user_logged_in
    
    def index
        if current_user
          redirect_to restaurants_path
        else
          render "index"
        end
    end
end