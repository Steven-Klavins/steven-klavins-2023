require 'rails_helper'

RSpec.describe "experiences/new", type: :view do
  before(:each) do
    assign(:experience, Experience.new(
      company: "MyString",
      position: "MyString",
      description: "MyText",
      company_url: "www.google.com"
    ))
  end

  it "renders new experience form" do
    render
    assert_select "form[action=?][method=?]", experiences_path, "post" do
      assert_select "input[name=?]", "experience[company]"
      assert_select "input[name=?]", "experience[position]"
      assert_select "textarea[name=?]", "experience[description]"
    end
  end
end