require 'rails_helper'

RSpec.feature "Blog Creation", type: :feature do

  before(:each) do
    @cat_1 = Category.create!(name: "Ruby")
    @cat_2 = Category.create!(name: "Java")
    @cat_3 = Category.create!(name: "Python")

    @blog_1 = Blog.create!(title: "Awesome Blog 1", body: "Some good content for 1")
    @blog_2 = Blog.create!(title: "Awesome Blog 2", body: "Some good content for 2")
    @blog_3 = Blog.create!(title: "Awesome Blog 3", body: "Some good content for 3")

    # Join
    BlogsCategory.create!(blog_id: @blog_1.id, category_id: @cat_3.id)
    BlogsCategory.create!(blog_id: @blog_2.id, category_id: @cat_1.id)
    BlogsCategory.create!(blog_id: @blog_3.id, category_id: @cat_1.id)
    BlogsCategory.create!(blog_id: @blog_3.id, category_id: @cat_2.id)

    # Blogs have the following categories associated from the setup above.
    # blog_1 => ['Python']
    # blog_2 => ['Ruby']
    # blog_3 => ['Ruby', 'Java']
    # Create and sign in the user with devise test helpers

    @user = User.create!(email: "test@testing.net", password: "123456")
    sign_in(@user)
  end

  context "Blogs should sort by specified categories" do
    scenario "The blog home page should contain all blogs from all categories", js: true do
      visit blogs_path
      expect(page).to have_content "Awesome Blog 1"
      expect(page).to have_content "Awesome Blog 2"
      expect(page).to have_content "Awesome Blog 3"
    end

    scenario "Category 1 should only show it's associated blogs", js: true do
      visit category_path @cat_1
      expect(page).to have_content "Awesome Blog 2"
      expect(page).to have_content "Awesome Blog 3"
      expect(page).to_not have_content "Awesome Blog 1"
    end

    scenario "Category 2 should only show it's associated blogs", js: true do
      visit category_path @cat_2
      expect(page).to have_content "Awesome Blog 3"
      expect(page).to_not have_content "Awesome Blog 1"
      expect(page).to_not have_content "Awesome Blog 2"
    end

    scenario "Category 3 should only show it's associated blogs", js: true do
      visit category_path @cat_3
      expect(page).to have_content "Awesome Blog 1"
      expect(page).to_not have_content "Awesome Blog 2"
      expect(page).to_not have_content "Awesome Blog 3"
    end

    scenario "All categories should be present to select from the side panel", js: true do
      # Clear the blog page to ensure the expectation is not confused blog tags.
      Blog.delete_all
      visit blogs_path
      expect(page).to have_content "Ruby"
      expect(page).to have_content "Java"
      expect(page).to have_content "Python"
    end
  end
end