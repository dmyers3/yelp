require 'spec_helper'

feature "Add business" do
  background do
    @dan = Fabricate(:user)
    sign_in(@dan)
  end
  
  scenario "Creating business with valid parameters" do
    create_business()
    expect(page).to have_selector("div.alert-success")
    expect(page).to have_content(Business.first.name)
  end
  
  scenario "Creating business with invalid parameters" do
    visit new_business_path
    fill_in "Business Name", with: "Sample Business"
    click_button "Create Business"
    
    expect(page).to have_selector("span.help-block")
    expect(current_path).to eq(businesses_path)
  end
end