require 'rails_helper'

RSpec.feature "Experience", type: :feature do

  before(:each) do
    @user = User.create!(email: "test@testing.net", password: "123456")
    sign_in(@user)

    Experience.create!(
      company: "Company",
      position: "Software Engineer",
      description: "A cool place to work",
      start_date: 1.year.ago.to_date,
      end_date: Date.current,
      company_url: "www.google.com",
      company_logo: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'logo.png'), 'image/png')
    )

  end

  context "An admin should be a able to perform crud actions on experiences" do
    scenario "A site visitor should not see the toolbar" do
      sign_out(@user)
      visit root_path
      expect(page).to have_no_selector('#experience-toolbar')
    end

    scenario "An admin should see the toolbar" do
      visit root_path
      expect(page).to have_selector('#experience-toolbar')
    end

    scenario "An adin should be able to update an experience" do
      visit root_path
      find("#edit-experience-#{Experience.last.id}").click
      fill_in "experience_description", with: "Updated content"
      click_on "Update Experience"
      expect(page).to have_content("Updated content")
    end

    scenario "An admin should be able to delete an experience", js: true do
      experience_id = Experience.last.id
      visit root_path
      find("#delete-experience-#{experience_id}").click
      find("#destroy-experience-#{experience_id}").click
      expect(page).to have_no_css("#destroy-experience-#{experience_id}", wait: 20)
      expect(Experience.count).to eq(0)
    end

    scenario "An admin should be able create an experience" do
      visit root_path
      click_on "Add +"
      expect(page).to have_content("New experience")
      fill_in "experience_company", with: "Google"
      fill_in "experience_position", with: "Software Engineer"
      attach_file('experience_company_logo', Rails.root.join('spec', 'fixtures', 'images', 'logo.png'))
      fill_in "experience_description", with: "A new experience at Google"
      fill_in 'experience_start_date', with: '2019-09-30'
      fill_in 'experience_end_date', with: '2021-09-30'
      click_on "Create Experience"
      expect(page).to have_content("A new experience at Google")
    end
  end
end