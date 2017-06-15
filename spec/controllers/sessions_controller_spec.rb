require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to the root page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to root_path
    end
  end
  
  describe "POST create" do
    context "with valid credentials" do
      let(:dan) { Fabricate(:user) }
      before do
        post :create, params: { email: dan.email, password: dan.password }
      end
      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(dan.id)
      end
      
      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid credentials" do
      let(:dan) { Fabricate(:user) }
      before do
        post :create, params: { email: dan.email, password: dan.password + 'sadklsaf' }
      end
      it "gives error message" do
        expect(flash[:danger]).not_to be_blank
      end
      
      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to eq(nil)
      end
      
      it "renders the login page" do
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end
    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end
    
    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end