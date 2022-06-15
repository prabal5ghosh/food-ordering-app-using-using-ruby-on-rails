class FooditemsController < ApplicationController
    # skip_before_action :ensure_user_logged_in  
    before_action :set_fooditem, except: [:index, :new, :create, :edit, :update]
    skip_before_action :verify_authenticity_token

    def index
        if params[:restaurant_id]
            @restaurant = Restaurant.find_by(id: params[:restaurant_id])
            @fooditems= @restaurant.fooditems
        else
            @fooditems= Fooditem.all
        end
    end

    def new
        if params[:restaurant_id]
            @restaurant = Restaurant.find_by(id: params[:restaurant_id])
            @fooditem = @restaurant.fooditems.build
        else
            @fooditem= Fooditem.new
            @fooditem.build_restaurant
        end
    end
    def create
        if params[:restaurant_id]
            @restaurant = Restaurant.find_by(id: params[:restaurant_id])
            @fooditem = @restaurant.fooditems.build(fooditem_params)  
        else         
            @fooditem = Fooditem.new(fooditem_params)
        end
        if @fooditem.save
            redirect_to restaurant_fooditems_path
        else
            flash[:error]= @fooditem.errors.full_messages.join(", ")
            render :new
        end
    end

    def show
        id= params[:id]
        @fooditem=Fooditem.find(params[:id])
        render "show"
    end

    def edit
        @restaurant = Restaurant.find_by(id: params[:restaurant_id])
        id= params[:id]
        @fooditem=Fooditem.find(params[:id])
    end

    def update
        @restaurant = Restaurant.find_by(id: params[:restaurant_id])
        @fooditem=Fooditem.find(params[:id])
        if @fooditem.update(fooditem_params)
            redirect_to  restaurant_fooditem_path(@fooditem.restaurant_id)
        else 
            render 'edit'
        end
    end

    def destroy
        @restaurant = Restaurant.find_by(id: params[:restaurant_id])
        @fooditem.destroy
        if current_user.role_id == 2
            redirect_to restaurant_fooditems_url
        elsif current_user.role_id == 4         
            redirect_to user_restaurant_fooditems_path
        else
            
        end
    
    end

    private
    def fooditem_params
        params.require(:fooditem).permit(:restaurant_id, :food_name, :price, :veg_food, :category_id)   
    end
    
    def set_fooditem
        @fooditem = Fooditem.find_by_id(params[:id]) 
    end

end





































# class FooditemsController < ApplicationController
#     skip_before_action :ensure_user_logged_in   
#     def index
#         id= params[:id] 
#         @fooditems=Fooditem.all
#         render "index"
#     end

#     def new       
#         @fooditem = Fooditem.new
#     end

#     def show
#         id= params[:id]
#         @fooditem=Fooditem.find(params[:id])
#         render "restaurant"
#     end

#     def create
#         catagory = Category.find_by(catagory_name: params[:catagory_name])
#         food_name = params[:food_name]
#         price=params[:price]
#         veg_food=params[:veg_food]
#         if veg_food == "true"
#             veg_food = true
#         else
#             veg_food = false
#         end
#         @fooditem= Fooditem.new(
#             food_name: food_name,
#             price: price,
#             veg_food: veg_food,
#             category_id: catagory.id,
#             restaurant_id: @restaurant.id
#         )
#         if @fooditem.save
#             redirect_to fooditems_path
#         else
#             flash[:error]= @fooditem.errors.full_messages.join(", ")
#             redirect_to restaurants_path
#         end
#     end
# end



# class FooditemsController < ApplicationController
#     # skip_before_action :ensure_user_logged_in, :except => [:landing, :connect, :create]
#     skip_before_action :ensure_user_logged_in   
#     def index
#         # id= params[:id]
#           # @fooditems=Fooditem.where(restaurant_id: restaurants.id)
#         # @fooditems=Fooditem.all
#         # restaurant_id = params[:restaurant_id]
#         @restaurant = Restaurant.find(params[:restaurant_id])
#         @fooditems = @restaurant.fooditems
#         render "index"
#     end
#     def new
#         # @restaurant = Restaurant.find(params[:restaurant_id].to_i)
#         # @restaurant = Restaurant.find(params[:id])
#         @fooditem = @restaurant.fooditems.build
#         # @fooditem = Fooditem.new
#     end
#     def edit
#     end

#     def create
#         @fooditem = @restaurant.fooditems.build(food_params)
#         # @restaurant = Restaurant.find(params[:restaurant_id].to_i) # gallery_id is passed in the URL
#         # @restaurant = Restaurant.find(params[:restaurant_id])
#         # @fooditem = @restaurant.fooditems.build(params[:fooditem])
#         # @fooditem = Fooditem.new(food_params)
#         # if @fooditem.save
#         # redirect_to restaurant_fooditems_path	
#         # end
#         # else
#         # # fail
#         # end
#         respond_to do |format|
#             if @fooditem.save
#                 format.html { redirect_to @fooditem, notice: 'Post was successfully created.' }
#                 format.json { render :show, status: :created, location: @fooditem }
#             else
#                 format.html { render :new }
#                 format.json { render json: @fooditem.errors, status: :unprocessable_entity }
#             end
#         end       
#     end
#     private
#     def food_params   
#         # byebug
#         params.require(:fooditem).permit(:restaurant_id, :food_name, :price, :veg_food, :catagory_id)    
#     end

# end
