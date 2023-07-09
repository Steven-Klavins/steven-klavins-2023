require 'rails_helper'

RSpec.describe User, type: :model do
  it "allows creation of a valid user" do
    user = User.new(
      email: "test@testing.net",
      password: "123456"
    )
    expect(user).to be_valid
  end

  it "does not allow creation of a invalid user" do
    user = User.new(
      email: "test@testing.net",
      password: ""
    )
    expect(user).to_not be_valid
  end

  it "does not allow creation of a user with a password less than 6 characters" do
    user = User.new(
      email: "test@testing.net",
      password: "ab12"
    )
    expect(user).to_not be_valid
  end
end