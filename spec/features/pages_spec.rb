require 'rails_helper'

RSpec.feature "Pages", type: :feature do
  context "Navigation of stand alone pages" do
    scenario "A visitor to the site can visit the home page" do
      visit '/'
      expect(page).to have_content "Welcome"
    end

    scenario "A visitor to the site can visit the about page" do
      visit about_path
      expect(page).to have_content "About"
    end

    scenario "A visitor to the site can visit the contact page" do
      visit contact_path
      expect(page).to have_content "Contact"
    end
  end
end