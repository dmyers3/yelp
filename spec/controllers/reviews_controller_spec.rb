require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:biz_a) { Fabricate(:business) }
    let(:dan) { Fabricate(:user) }
    
    it "redirects unauthenticated user" do
      post :create, params: { review: Fabricate.attributes_for(:review), business: biz_a, user: dan, business_id: biz_a.id }
      expect(response).to redirect_to(login_path)
    end
    
    context "from form on business#show" do
      context "with valid input" do
        before do
          session[:user_id] = dan.id
          post :create, params: { review: Fabricate.attributes_for(:review), business: biz_a, user: dan, business_id: biz_a.id }
        end
        
        it "redirects to the business's page" do
          expect(response).to redirect_to(business_path(biz_a))
        end
        
        it "creates a reviw" do
          expect(Review.count).to eq(1)
        end
        
        it "creates a review associated with the business" do
          expect(Review.first.business).to eq(biz_a)
        end
        
        it "creates a review associated with the signed in user" do
          expect(Review.first.user).to eq(dan)
        end
      end
      
      context "with invalid input" do
        before do
          session[:user_id] = dan.id
          post :create, params: { review: { description: "Test Review" }, business: biz_a, user: dan, business_id: biz_a.id }
        end
        
        it "doesn't create a review" do
          expect(Review.count).to eq(0)
        end
        
        it "renders the business controller's show template" do
          expect(response).to render_template('businesses/show')
        end
      end
    end
    
    context "from form on reviews#new" do
      context "with valid input" do
        before do
          session[:user_id] = dan.id
          post :create, params: { review: Fabricate.attributes_for(:review).merge(business_id: biz_a.id), business: biz_a, user: dan }
        end
        
        it "redirects to the business's page" do
          expect(response).to redirect_to(business_path(biz_a))
        end
        
        it "creates a reviw" do
          expect(Review.count).to eq(1)
        end
        
        it "creates a review associated with the business" do
          expect(Review.first.business).to eq(biz_a)
        end
        
        it "creates a review associated with the signed in user" do
          expect(Review.first.user).to eq(dan)
        end
      end
      
      context "with invalid input" do
        before do
          session[:user_id] = dan.id
          post :create, params: { review: { description: "Test Review", business_id: biz_a.id }, business: biz_a, user: dan }
        end
        
        it "doesn't create a review" do
          expect(Review.count).to eq(0)
        end
        
        it "renders the review controller's new template" do
          expect(response).to render_template('new')
        end
      end
    end
  end
end