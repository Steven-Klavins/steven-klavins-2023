require 'rails_helper'

RSpec.describe "blogs/show", type: :view do
  before(:each) do
    assign(:blog, Blog.create!(
      title: "Title",
      body: "MyText"
    ))
  end
end