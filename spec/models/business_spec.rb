require 'spec_helper'

describe Business do
  it { should have_many(:reviews) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:phone_number) }
  
  it "orders businesses by name A-Z" do
    biz_z = Fabricate(:business, name: "Zaland")
    biz_a = Fabricate(:business, name: "Ann's")
    biz_m = Fabricate(:business, name: "Monticello")
    expect(Business.all).to eq([biz_a, biz_m, biz_z])
  end
  
  describe "#recent_reviews" do
    it "if 5 or less reviews exist it gives those reviews ordered by date created (newest first)" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, business: business)
      review2 = Fabricate(:review, business: business)
      review3 = Fabricate(:review, business: business)
      expect(business.recent_reviews).to eq([review3, review2, review1])
    end
    
    it "gives 5 most recent reviews if more than 5 reviews exist" do
      business = Fabricate(:business)
      review1 = Fabricate(:review, business: business)
      review2 = Fabricate(:review, business: business)
      review3 = Fabricate(:review, business: business)
      review4 = Fabricate(:review, business: business)
      review5 = Fabricate(:review, business: business)
      review6 = Fabricate(:review, business: business)
      
      expect(business.recent_reviews).not_to include(review1)
    end
  end
  
end