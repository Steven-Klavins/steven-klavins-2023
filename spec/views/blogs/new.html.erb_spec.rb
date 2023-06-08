require 'rails_helper'

RSpec.describe "blogs/new", type: :view do
  before(:each) do
    assign(:blog, Blog.new(
      title: "MyString",
      body: "MyText"
    ))
  end
end