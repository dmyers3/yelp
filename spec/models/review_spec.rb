require 'spec_helper'

describe Review do
  it { should belong_to(:business) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:rating) }
  
  it "orders reviews by date created, newest first" do
    first_review = Fabricate(:review)
    second_review = Fabricate(:review)
    expect(Review.all).to eq([second_review, first_review])
  end
end