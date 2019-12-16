class User < ActiveRecord::Base
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false, allow_blank: true, message: ": Umm, did you mean to log in??"
  validates :password, length: { minimum: 3 }
  validates :password_confirmation, length: { minimum: 3 }
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    User.find_by_email(email.downcase.strip).try(:authenticate, password) || nil
  end

end
