class User < ActiveRecord::Base
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: { message: "can't be blank" }
  validates_uniqueness_of :email, allow_blank: true, message: ": Umm, did you mean to log in??"
  has_secure_password

end
