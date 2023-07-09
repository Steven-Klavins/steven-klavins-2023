require 'rails_helper'

RSpec.feature "Blog Creation", type: :feature do

  before(:each) do
    Category.create(name: "Ruby")
    Category.create(name: "Java")
    Category.create(name: "Python")
    @blog_1 = Blog.create!(title: "Awesome Blog", body: "Some good content")
    @user = User.create!(email: "test@testing.net", password: "123456")

    sign_in(@user)
  end

  context "Creating and editing blogs" do
    scenario "An admin can create a valid blog" do
      visit new_blog_path
      fill_in "blog_title", with: "A Cool Blog"
      fill_in_trix_editor("blog_body_trix_input_blog", "Some awesome content")
      click_on "Create Blog"
      expect(page).to have_content "A Cool Blog"
    end

    scenario "An admin can create a blog with a category which will be displayed on the show page" do
      visit new_blog_path
      fill_in "blog_title", with: "A Cool Blog"
      select "Java", from: "blog_category_ids"
      fill_in_trix_editor("blog_body_trix_input_blog", "Some awesome content")
      click_on "Create Blog"
      expect(page).to have_content "Java"
    end

    scenario "An admin can create a blog with multiple categories" do
      visit new_blog_path
      fill_in "blog_title", with: "A Cool Blog"
      select "Java", from: "blog_category_ids"
      select "Ruby", from: "blog_category_ids"
      fill_in_trix_editor("blog_body_trix_input_blog", "Some awesome content")
      click_on "Create Blog"
      expect(page).to have_content "Java"
      expect(page).to have_content "Ruby"
    end

    scenario "An admin can delete an existing blog" do
      visit blog_path(id: @blog_1.id)
      click_on "Delete"
      expect(page).to_not have_content "Awesome Blog"
    end

    scenario "An admin can edit an existing blog" do
      visit blog_path(id: @blog_1.id)
      click_on "Edit"
      fill_in_trix_editor("blog_body_trix_input_blog_#{@blog_1.id}", "Updated content")
      click_on "Update Blog"
      expect(page).to have_content "Updated content"
    end
  end
end