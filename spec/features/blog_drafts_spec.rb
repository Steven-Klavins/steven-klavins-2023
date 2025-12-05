require 'rails_helper'
require 'trix_helper'

RSpec.feature "Blog Drafts", type: :feature do

  before(:each) do
    @category = Category.create!(name: "Java")
    @blog_1 = Blog.create!(title: "Awesome Blog", body: "Some good content")
    @user = User.create!(email: "test@testing.net", password: "123456")

    sign_in(@user)
  end

  context "Blogs should only appear where appropriate based on there draft status" do
    scenario "When a blog is created as a draft we should redirect to the admin panel" do
      visit new_blog_path
      fill_in "blog_title", with: "A Cool Blog"
      fill_in_trix_editor("blog_body_trix_input_blog", "Some awesome content")
      check "Draft"
      click_on "Create Blog"
      expect(page).to have_content "Admin"
    end

    scenario "When a blog is updated as a draft we should redirect to the admin panel", js: true do
      visit blogs_path
      click_on "Awesome Blog"
      click_on "Edit"
      check "Draft"
      click_on "Update Blog"
      expect(page).to have_content "Admin"
    end

    scenario "When a blog is updated as a draft it should not be viewable on the show page", js: true do
      visit blogs_path
      click_on "Awesome Blog"
      click_on "Edit"
      check "Draft"
      click_on "Update Blog"
      visit blogs_path
      expect(page).to_not have_content "Awesome Blog"
    end

    scenario "When a blog is updated as a draft it should be viewable in the admin panel", js: true do
      visit blogs_path
      click_on "Awesome Blog"
      click_on "Edit"
      check "Draft"
      click_on "Update Blog"
      expect(page).to have_content("Admin", wait: 60)
      click_on "Drafts ⏷"
      expect(page).to have_content("Awesome Blog", wait: 20)
    end

    scenario "A blog marked a draft should not show in categories either" do
      visit blog_path(@blog_1)
      click_on "Edit"
      select "Java", from: "blog_category_ids"
      check "Draft"
      click_on "Update Blog"
      visit category_path(@category)
      expect(page).to_not have_content "Awesome Blog"
    end

    scenario "A blog no longer marked as a draft should show in categories", js: true do
      blog = Blog.create!(title: "Draft Blog", body: "Some good content", draft: true)
      BlogsCategory.create!(blog_id: blog.id, category_id: @category.id)
      visit admin_panel_path
      expect(page).to have_content("Admin", wait: 60)
      click_on "Drafts ⏷"
      find("a[href='#{edit_blog_path(blog)}']").click
      uncheck "Draft"
      click_on "Update Blog"
      visit blogs_path
      expect(page).to have_content("Blog", wait: 40)
      expect(page).to have_selector(".blog-categories-box", wait: 20)
      within('.blog-categories-box') do
        click_link 'Java'
      end
      expect(page).to have_content "Draft Blog"
    end

    scenario "A blog no longer marked as a draft should show on the blogs index", js: true do
      blog = Blog.create!(title: "Draft Blog 2", body: "Some good content", draft: true)
      BlogsCategory.create!(blog_id: blog.id, category_id: @category.id)
      visit admin_panel_path
      expect(page).to have_content("Admin", wait: 60)
      click_on "Drafts ⏷"
      find("a[href='#{edit_blog_path(blog)}']").click
      uncheck "Draft"
      click_on "Update Blog"
      visit blogs_path
      expect(page).to have_content("Draft Blog 2", wait: 20)
    end

    scenario "A blog no longer marked as a draft should no longer show in the admin panel", js: true do
      blog = Blog.create!(title: "Draft Blog 3", body: "Some good content", draft: true)
      BlogsCategory.create!(blog_id: blog.id, category_id: @category.id)
      visit admin_panel_path
      expect(page).to have_content("Admin", wait: 60)
      click_on "Drafts ⏷"
      find("a[href='#{edit_blog_path(blog)}']").click
      uncheck "Draft"
      click_on "Update Blog"
      visit admin_panel_path
      expect(page).to have_content("Admin", wait: 60)
      click_on "Drafts ⏷"
      expect(page).to_not have_content("Draft Blog 3", wait: 20)
    end

    scenario "Publishing a blog should remove it from drafts", js: true do
      Blog.create!(title: "Draft Blog 4", body: "Some good content", draft: true)
      visit admin_panel_path
      expect(page).to have_content("Admin", wait: 60)
      click_on "Drafts ⏷"
      click_on "Publish"
      expect(Blog.last.draft).to eq(false)
    end

    scenario "Blogs in drafts should not be visible on their show pages" do
      blog = Blog.create!(title: "Draft Blog 5", body: "Some good content", draft: true)
      error = 'can\'t find record with friendly id: "draft-blog-5"'
      expect { visit blog_path(blog) }.to raise_error(ActiveRecord::RecordNotFound, error)
    end
  end
end