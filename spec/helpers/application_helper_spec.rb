require 'nokogiri'

RSpec.describe ApplicationHelper, type: :helper do

  describe "get_description" do
    it "should return a string value from the yaml" do
      expected_value = "Full-Stack Engineer with over 2 years of industry experience, Makers Academy alumnus, and university graduate holding a BA in Digital Arts and Technology."
      expect(get_description("Home", "heading")).to eq(expected_value)
    end
  end

  describe "get_description" do
    it "should return a string value from the yaml" do
      expected_value = "Full-Stack Engineer with over 2 years of industry experience, Makers Academy alumnus, and university graduate holding a BA in Digital Arts and Technology."
      expect(get_description("Home", "heading")).to eq(expected_value)
    end

    it "should return an unavailable message if the requested description is not in the yaml" do
      expected_value = "Description unavailable..."
      expect(get_description("Home", "this_does_not_exist")).to eq(expected_value)
    end
  end

  describe "svg" do
    it "should return an SVG if it is present" do
      svg_value = svg('steven-klavins-logo.svg')
      expect(Nokogiri::HTML::Document.parse(svg_value).xpath('//svg')).to_not eq(nil)
    end

    it "should return a string value if the svg does not exist" do
      fake_value = "fake_svg_image.svg"
      expect(svg(fake_value)).to eq(fake_value)
    end

    it "should return a svg image with an embedded link if a url is provided" do
      svg_value = svg('steven-klavins-logo.svg', root_path)
      expect(Nokogiri::HTML::Document.parse(svg_value).xpath('//a[@href]')[0].attribute_nodes[0].value).to eq('/')
    end
  end
end