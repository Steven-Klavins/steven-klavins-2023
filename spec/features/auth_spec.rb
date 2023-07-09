require 'rails_helper'

RSpec.feature "Authentication", type: :feature do

  before(:each) do
    @blog_1 = Blog.create!(title: "Awesome Blog", body: "Some good content")
    # Create and sign in the user with devise test helpers
    @user = User.create!(email: "test@testing.net", password: "123456")
  end

  context "Authentication is implemented where appropriate" do
    scenario "A non-authenticated user should not see the Sign out button" do
      visit new_blog_path
      expect(page).to_not have_content "Sign out"
    end

    scenario "A authenticated user should see the Sign out button" do
      sign_in(@user)
      visit root_path
      expect(page).to have_content "Sign out"
    end

    scenario "A logged in user should be able to visit the new blog path" do
      sign_in(@user)
      visit new_blog_path
      expect(page).to have_content "New blog"
    end

    scenario "A non-authenticated user attempting to create a blog should be redirected to root" do
      visit new_blog_path
      expect(page).to have_content "Welcome"
    end

    scenario "A logged in user should see blog actions on show" do
      sign_in(@user)
      visit blog_path(id: @blog_1.id)
      expect(page).to have_content "Edit"
      expect(page).to have_content "Delete"
    end

    scenario "A non-authenticated user should not see blog actions on show" do
      visit blog_path(id: @blog_1.id)
      expect(page).to_not have_content "Edit"
      expect(page).to_not have_content "Delete"
    end
  end
end