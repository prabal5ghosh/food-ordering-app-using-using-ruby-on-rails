class WelcomeController < ApplicationController
    # skip_before_action :ensure_user_logged_in
    def index
        render "index"
    end

end
  
  