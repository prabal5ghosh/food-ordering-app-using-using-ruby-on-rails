class RestaurantsController <ApplicationController
    skip_before_action :ensure_user_logged_in
    skip_before_action :verify_authenticity_token

    def new
        @restaurant = Restaurant.new
        # render "restaurants/new"
    end

    def index
        if current_user.role_id == 4
            # @restaurants=Restaurant.all
            id= params[:id]
            @user = User.find_by(id: params[:user_id])
            @restaurants= @user.restaurants
            # @restaurants=Restaurant.where(user_id: @user.id)
            # @restaurants=Restaurant.where(user_id: params[:id])

            @restaurant = Restaurant.new
            render "index"
        else
            @restaurants=Restaurant.where(user_id: current_user.id)
            @restaurant = Restaurant.new
            render "index"
        end
    end
    
    def show
        id= params[:id]
        @restaurant=Restaurant.find(params[:id])
        if current_user.role_id == 2
            render "restaurant"
        elsif current_user.role_id == 4
            render "restaurant_admin"
        else
        
        end
    end

    def create      
        @restaurant= Restaurant.new(restaurant_params)
        @restaurant.user_id = current_user.id
        if @restaurant.save
            redirect_to restaurants_path
        else
            flash[:error]= @restaurant.errors.full_messages.join(", ")
            redirect_to restaurants_path
        end
    end
    
    def edit
        if current_user.role_id == 2
            # id = params[:id]
            @restaurant=Restaurant.find(params[:id])
        elsif current_user.role_id == 4
            @user = User.find_by(id: params[:user_id])
            id= params[:id]
            @restaurant=Restaurant.find(params[:id])
        end
        
    end

    def update
        @restaurant=Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
            # restaurant.save!
            if current_user.role_id == 2
                redirect_to @restaurant
            elsif current_user.role_id == 4
                redirect_to user_restaurants_path
            end
        else 
            flash[:error]= @restaurant.errors.full_messages.join(", ")
            render 'edit'
        end
    end

    def destroy
        id= params[:id]
        @user = User.find_by(id: params[:user_id])
        Restaurant.find(params[:id]).destroy
        flash[:success] = "Restaurant deleted"
        if current_user.role_id == 2
            redirect_to restaurants_path
        elsif current_user.role_id == 4         
            redirect_to users_path
        else
        end
    end

    # def hellow
    #     # @restaurant=Restaurant.find(params[:id])
    # render '/fooditems/index'
    # end

    private
    def restaurant_params   
        params.require(:restaurant).permit(:veg_restaurant, :restaurant_name, :address, :opening_time, :closing_time)    
    end
    
end