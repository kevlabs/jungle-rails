class User < ActiveRecord::Base
  has_secure_password
  # validates :email, uniqueness: { strict: true, message: "Please #{::link_to 'login', [:login]} to access your account" }
end
