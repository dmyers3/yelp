require 'spec_helper'

feature "Signing in" do
  background do
    @dan = Fabricate(:user)
  end
  
  scenario "Signing in with correct credentials" do
    sign_in(@dan)
    expect(page).to have_content "Welcome, #{@dan.first_name}"
  end
  
  scenario "Signing in with incorrect credentials" do
    visit login_path
    fill_in 'Email Address', with: @dan.email
    fill_in 'Password', with: "#{@dan.password}adsjkda"
    click_button 'Sign in'
    expect(page).to have_selector("div.alert-danger")
    expect(current_path).to eq(login_path)
  end
end