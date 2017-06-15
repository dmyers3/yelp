require 'spec_helper'

feature 'Add review' do
  
  background do
    @dan = Fabricate(:user)
    sign_in(@dan)
  end
  
  scenario "from businesses#show page" do
    biz_a = Fabricate(:business)
    visit business_path(biz_a)
    select("4 Stars", from: "review_rating")
    fill_in "Description", with: "Great!"
    click_button "Submit Review"
    expect(page).to have_content ("Rating: 4/5")
  end

  scenario "from reviews#new page" do
    biz_a = Fabricate(:business)
    visit new_review_path
    select(biz_a.name, from: "review_business_id")
    select("4 Stars", from: "review_rating")
    fill_in "Description", with: "Great!"
    click_button "Submit Review"
    expect(page).to have_content ("Rating: 4/5")
  end
end
