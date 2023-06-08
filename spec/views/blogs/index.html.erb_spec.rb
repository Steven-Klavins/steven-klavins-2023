require 'rails_helper'

RSpec.describe "blogs/index", type: :view do
  before(:each) do
    assign(:blogs, [
      Blog.create!(
        title: "Title",
        body: "MyText"
      ),
      Blog.create!(
        title: "Title",
        body: "MyText"
      )
    ])
  end
end