require 'rails_helper'

RSpec.describe "experiences/edit", type: :view do
  let(:experience) {
    Experience.create!(
      company: "MyString",
      position: "MyString",
      description: "MyText",
      start_date: 1.year.ago.to_date,
      end_date: Date.current,
      company_url: "www.google.com",
      company_logo: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'logo.png'), 'image/png')
    )
  }

  before(:each) do
    assign(:experience, experience)
  end

  it "renders the edit experience form" do
    render

    assert_select "form[action=?][method=?]", experience_path(experience), "post" do

      assert_select "input[name=?]", "experience[company]"

      assert_select "input[name=?]", "experience[position]"

      assert_select "textarea[name=?]", "experience[description]"
    end
  end
end
