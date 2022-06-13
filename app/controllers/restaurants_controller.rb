class RestaurantsController <ApplicationController
    skip_before_action :ensure_user_logged_in

    def new
        @restaurant = Restaurant.new
        # render "restaurants/new"
    end

    def index
        @restaurants=Restaurant.where(user_id: current_user.id)
        @restaurant = Restaurant.new
        render "index"
    end
    
    def show
        id= params[:id]
        @restaurant=Restaurant.find(params[:id])
        render "restaurant"
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
        # id = params[:id]
        @restaurant=Restaurant.find(params[:id])
    end

    def update
        @restaurant=Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
            # restaurant.save!
            redirect_to @restaurant
        else 
            flash[:error]= @restaurant.errors.full_messages.join(", ")
            render 'edit'
        end
    end

    def destroy
        Restaurant.find(params[:id]).destroy
        flash[:success] = "Restaurant deleted"
        redirect_to restaurants_path
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