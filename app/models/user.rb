class User < ApplicationRecord
    has_secure_password
    belongs_to :role
    has_many :restaurants , dependent: :destroy
    validates :first_name, presence: true, length: {minimum: 3, maximum: 10}
    validates :last_name, presence: true, length: {minimum: 2, maximum: 10}
    validates :email , presence: true, uniqueness: true
    validates :password , presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    validates :first_name, format: { with: /\A[a-zA-Z]+\z/, message: ':only letters are allowed for first_name '}
    validates :last_name, format: { with: /\A[a-zA-Z]+\z/, message: ':only letters are allowed for last_name '}
    
    # this instance method is used to display the full name of user
    def full_name
        "#{first_name} #{last_name}"
    end    
end
