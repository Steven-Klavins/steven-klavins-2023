require 'rails_helper'
include ApplicationHelper

RSpec.feature "Description Editor", type: :feature do
  context "The user should be able to edit descriptions when logged in" do
    scenario "A visitor to should not have access to edit links" do
      visit root_path
      expect(page).to_not have_selector(:link_or_button, 'Edit')
    end

    scenario "A site admin should have access to edit links" do
      @user = User.create!(email: "test@testing.net", password: "123456")
      sign_in(@user)
      visit root_path
      expect(page).to have_selector(:link_or_button, 'Edit')
    end

    scenario "A site admin should be able to update a description", js: true do
      @user = User.create!(email: "test@testing.net", password: "123456")
      sign_in(@user)
      visit root_path
      find('#edit-languages_proficient_in', visible: true).click
      form = find(:xpath, '//form[@id="languages_proficient_in-description_form"]')
      form.fill_in('description', with: 'test')
      click_on("Update", :match => :first)
      expect(page).to have_content "test"
      # A quick check to make sure the YAML updated using the application helper.
      expect(get_description("Home", "languages_proficient_in")).to eq "test"
    end
  end
end