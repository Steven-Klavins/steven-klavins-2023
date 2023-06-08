require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @category_1 = Category.create(name: "Ruby")
  end

  it "allows a user create a valid category" do
    category = Category.create(name: "Java")
    expect(category).to be_valid
  end

  it "validates category name length is more than 1" do
    category = Category.new(name: "")
    expect(category).to_not be_valid
  end

  it "validates presence of a category name" do
    category = Category.new()
    expect(category).to_not be_valid
  end

  it "validates uniqueness of a category name" do
    Category.create(name: "Java")
    category = Category.new(name: "Java")
    expect(category).to_not be_valid
  end
end