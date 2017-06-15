class Business < ActiveRecord::Base
  default_scope { order(name: :asc) }
  validates_presence_of :phone_number, :name
  validates :phone_number, uniqueness: true
  
  has_many :reviews
  
  def recent_reviews
    reviews.limit(5)
  end
end