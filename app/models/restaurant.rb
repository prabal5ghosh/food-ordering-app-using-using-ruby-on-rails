class Restaurant < ApplicationRecord
    has_many :fooditems, dependent: :destroy
    belongs_to :user
    validates :restaurant_name, presence: true, length: {minimum: 3, maximum: 30}
    validates :address, presence: true, length: {minimum: 3, maximum: 50}
    validates :opening_time, presence: true
    validates :closing_time, presence: true
    validates :veg_restaurant, inclusion: { in: [true, false] }

    after_commit :commit_operation_on_restaurant_name   # active rtecord call backs
    after_create :create_restaurant_name   # active rtecord call backs
    after_update :update_restaurant_name   # active rtecord call backs
    after_destroy :destroy_restaurant_name   # active rtecord call backs

    def commit_operation_on_restaurant_name
        if self.restaurant_name.present?
            name = self.restaurant_name
            puts "=========================Successful commit on restaurant : #{name}================="
        else
            puts "______________wrong operation_______________________"
        end
    end

    def create_restaurant_name
        if self.restaurant_name.present?
            name = self.restaurant_name
            puts "==========================Successful creation on restaurant : #{name}================="
        else
            puts "______________wrong operation_______________________"
        end
    end

    def update_restaurant_name
        if self.restaurant_name.present?
            name = self.restaurant_name
            puts "==============================Successful updation on restaurant : #{name}================="
        else
            puts "______________wrong operation_______________________"
        end
    end
    
    def destroy_restaurant_name
        if self.restaurant_name.present?
            name = self.restaurant_name
            puts "=================================Successful destroy on restaurant : #{name}================="
        else
            puts "______________wrong operation_______________________"
        end
    end

end
