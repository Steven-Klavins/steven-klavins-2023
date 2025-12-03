require 'rails_helper'

RSpec.describe Experience, type: :model do
  it "allows creation of a valid experience" do
    experience = Experience.new(
      company: "MyString",
      position: "MyString",
      description: "MyText",
      start_date: 1.year.ago.to_date,
      end_date: Date.current,
      company_url: "www.google.com",
      company_logo: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'logo.png'), 'image/png')
    )
    expect(experience).to be_valid
  end

  it "does not allow creation of a invalid experience" do
    experience = Experience.new(
      company: "",
      position: "MyString",
      description: nil,
      start_date: 1.year.ago.to_date,
      end_date: Date.current,
      company_url: "www.google.com",
      company_logo: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'logo.png'), 'image/png')
    )
    expect(experience).to_not be_valid
  end

  it "validate presence of a company logo" do
    experience = Experience.new(
      company: "MyString",
      position: "MyString",
      description: "MyText",
      start_date: 1.year.ago.to_date,
      end_date: Date.current,
      company_url: "www.google.com",
      company_logo: nil
    )
    expect(experience).to_not be_valid
  end

  it "formats display dates correctly" do
    experience = Experience.new(
      company: "MyString",
      position: "MyString",
      description: "MyText",
      start_date: Date.new(2021, 02, 1),
      end_date: Date.new(2023, 05, 1),
      company_url: "www.google.com",
      company_logo: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'logo.png'), 'image/png')
    )
    expect(experience.display_dates).to eq("02/2021 - 05/2023")
  end

  it "formats display dates with no end date correctly" do
    experience = Experience.new(
      company: "MyString",
      position: "MyString",
      description: "MyText",
      start_date: Date.new(2021, 02, 1),
      company_url: "www.google.com",
      company_logo: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'logo.png'), 'image/png')
    )
    expect(experience.display_dates).to eq("02/2021 - Present")
  end
end
