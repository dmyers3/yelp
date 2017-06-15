require 'spec_helper'

describe BusinessesController do
  describe "GET index" do
    it "sets the @businesses variable" do
      wendys = Fabricate(:business)
      burger_king = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([wendys, burger_king])
    end
  end
  
  describe "GET show" do
    let(:biz_a) { Fabricate(:business) }
    
    it "sets the @business variable" do
      get :show, params: { id: biz_a.id }
      expect(assigns(:business)).to eq(biz_a)
    end
    
    it "sets the @review variable when logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :show, params: { id: biz_a.id }
      expect(assigns(:review)).to be_a(Review)
    end
    
    it "doesn't set the @review variable when logged out" do
      get :show, params: { id: biz_a.id }
      expect(assigns(:review)).to eq(nil)
    end
  end
  
  describe "GET new" do
    it "redirects to the login page if not logged in" do
      get :new
      expect(response).to redirect_to login_path
    end
    
    it "sets the @business variable" do
      dan = Fabricate(:user)
      session[:user_id] = dan.id
      get :new
      expect(assigns(:business)).to be_a(Business)
    end
  end
  
  describe "POST create" do
    it "redirects to the login page if not logged in" do
      post :create, params: {business: Fabricate.attributes_for(:business)}
      expect(response).to redirect_to login_path
    end
    
    context "with valid input" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
        post :create, params: {business: Fabricate.attributes_for(:business)}
      end
      
      it "redirects to the business's page" do
        expect(response).to redirect_to business_path(Business.first.id)
      end
      
      it "creates a business" do
        expect(Business.count).to eq(1)
      end
    end
    
    context "with invalid input" do
      it "renders new business form" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        post :create, params: {business: Fabricate.attributes_for(:business, name: nil)}
        expect(response).to render_template(:new)
      end
    end
  end
end