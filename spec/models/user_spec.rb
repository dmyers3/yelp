require 'spec_helper'

describe User do
  it { should have_many(:reviews) }
  it { should validate_presence_of(:email) }
  it { should have_secure_password }
  
  describe "#full_name" do
    it "returns empty string if both first name and last name are empty" do
      user = Fabricate(:user, first_name: nil, last_name: nil)
      expect(user.full_name).to eq('')
    end
    
    it "returns just first name with no trailing space if last name is empty" do
      user = Fabricate(:user, last_name: nil)
      expect(user.full_name).to eq(user.first_name)
    end
    
    it "returns just last name with no leading space if first name is empty" do
      user = Fabricate(:user, first_name: nil)
      expect(user.full_name).to eq(user.last_name)
    end
    
    it "returns first name and last name separating by space" do
      user = Fabricate(:user)
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end
end