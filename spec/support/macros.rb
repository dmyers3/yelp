def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit login_path
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def create_business(a_business=nil)
  visit new_business_path
  business_attrs = Fabricate.attributes_for(:business)
  fill_in "Business Name", with: business_attrs[:name]
  fill_in "Phone number", with: business_attrs[:phone_number]
  click_button "Create Business"
end