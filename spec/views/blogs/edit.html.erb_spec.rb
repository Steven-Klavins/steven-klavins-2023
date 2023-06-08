require 'rails_helper'

RSpec.describe "blogs/edit", type: :view do
  let(:blog) {
    Blog.create!(
      title: "MyString",
      body: "MyText"
    )
  }

  before(:each) do
    assign(:blog, blog)
  end
end
