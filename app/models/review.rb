class Review < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  validates_presence_of :rating
  
  belongs_to :business
  belongs_to :user
end