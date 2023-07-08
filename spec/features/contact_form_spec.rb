require 'rails_helper'

RSpec.feature "Contact Form", type: :feature do
  context "Submission of contact forms" do
    scenario "A user should be redirected to the thank you page upon submission of valid contact form" do
      visit contact_path
      fill_in "contact_form_name", with: "Stephen Fry"
      fill_in "contact_form_subject", with: "Hello"
      fill_in "contact-email", with: "stephenfry@gmail.com"
      fill_in "contact_form_message", with: "Greetings, here's a cool message"
      click_on "Send"
      expect(page).to have_content "Thanks"
    end

    scenario "Until a fields are completed the submit but should remain disabled", js: true do
      visit contact_path
      fill_in "contact_form_name", with: "Stephen Fry"
      fill_in "contact_form_subject", with: "Hello"
      fill_in "contact-email", with: "stephenfry@gmail.com"
      expect(page).to have_button('Send', disabled: true)
    end

    scenario "When all fields are complete the send button should be enabled", js: true do
      visit contact_path
      fill_in "contact_form_name", with: "Stephen Fry"
      fill_in "contact_form_subject", with: "Hello"
      fill_in "contact-email", with: "stephenfry@gmail.com"
      fill_in "contact_form_message", with: "Greetings, here's a cool message"
      expect(page).to have_button('Send', disabled: false)
    end

    scenario "The send button should not be enabled if the email is invalid", js: true do
      visit contact_path
      fill_in "contact_form_name", with: "Stephen Fry"
      fill_in "contact_form_subject", with: "Hello"
      fill_in "contact-email", with: "stephenfry@gmail"
      fill_in "contact_form_message", with: "Greetings, here's a cool message"
      expect(page).to have_button('Send', disabled: true)
    end
  end
end