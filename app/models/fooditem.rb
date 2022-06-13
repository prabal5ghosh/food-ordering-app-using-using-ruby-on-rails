class Fooditem < ApplicationRecord
    belongs_to :restaurant
    belongs_to :category
    validates :food_name, presence: true, length: {minimum:3, maximum:20}
    validates :price, presence: true
    validates :veg_food, inclusion: { in: [true, false] } 
    validate :validate_price_check    # custom validation

    def validate_price_check
        if self.price.present?
            if price<1
                errors.add(:price, 'please provide a valid price')
            end
        end
    end
    
    scope :get_restaurant_fooditems, ->(restaurant_id) {where("restaurant_id = ?",restaurant_id)}

end
