require 'spec_helper'

describe UsersController do
  describe "GET show" do
    it "assigns @user" do
      dan = Fabricate(:user)
      get :show, params: { id: dan.id }
      expect(assigns(:user)).to eq(dan)
    end
  end
    
  describe "GET new" do
    it "sets @user if not logged in" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
    
    it "redirects to root page if logged in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to root_path
    end
  end
  
  describe "POST create" do
    it "redirects to root page if logged in" do
      session[:user_id] = Fabricate(:user).id
      post :create
      expect(response).to redirect_to root_path
    end
    
    it "sets @user" do
      post :create, params: { user: Fabricate.attributes_for(:user) }
      expect(assigns(:user)).to be_a(User)
    end
    
    context "with valid input" do
      before { post :create, params: { user: Fabricate.attributes_for(:user) } }
      
      it "creates the user" do
        expect(User.count).to eq(1)
      end
      
      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid input" do
      before { post :create, params: { user: { password: "password", full_name: "Dan Myers" }}}
      
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      
      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end
end