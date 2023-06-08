require 'rails_helper'

RSpec.describe Blog, type: :model do

  before(:each) do
    @category_1 = Category.create(name: "Ruby")
    @category_2 = Category.create(name: "Java")
  end

  it "allows a user create a valid blog" do
    blog = Blog.new(
      title: "New blog post",
      body: "Body Text",
    )
    expect(blog).to be_valid
  end

  it "validates presence of a blog title" do
    blog = Blog.new(
      body: "Body Text",
      )
    expect(blog).to_not be_valid
  end

  it "validates presence of a blog body" do
    blog = Blog.new(
      title: "New blog post",
      )
    expect(blog).to_not be_valid
  end

  it "limits blog titles to 60 charters" do
    blog = Blog.new(
      title: "Some Really Long Title Which Would Ruin My CSS And Be Very Hard To Read",
      body: "Another Test Body"
      )
    expect(blog).to_not be_valid
  end

  it "can have many associated categories" do
    blog = Blog.create!(
      title: "New blog post",
      body: "Test Body"
      )

    BlogsCategory.create!(blog_id: blog.id, category_id: @category_1.id)
    BlogsCategory.create!(blog_id: blog.id, category_id: @category_2.id)
    expect(blog.categories.count).to eq(2)
  end

  it "can have one associated category" do
    blog = Blog.create!(
      title: "New blog post",
      body: "Test Body"
    )

    BlogsCategory.create!(blog_id: blog.id, category_id: @category_2.id)
    expect(blog.categories.count).to eq(1)
  end
end
