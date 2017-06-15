class User < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :email
  has_secure_password
  
  def full_name
    "#{first_name} #{last_name}".strip
  end
end