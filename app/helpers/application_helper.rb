module ApplicationHelper
  require 'nokogiri'

  # Helper method for displaying SVGs
  # If a URL is provided manipulate the SVG wrapping it into a clickable link.

  def svg(image, url = nil)
    file_path = "#{Rails.root}/app/assets/images/svg/#{image}"
    begin
      if url
        doc = Nokogiri::XML(File.read(file_path))
        children = doc.root.children
        doc.root.children = "<a href='#{url}'>"
        doc.at("a").children = children
        doc.to_s.html_safe
      else
        File.read(file_path).html_safe
      end
    rescue
      # On failure read file just return the specified SVG argument as text.
      image.html_safe
    end
  end

  # Return my total years of experience.
  def years_experience
    start_date = DateTime.new(2021, 2)
    months = (Time.now.utc.to_date.year * 12 + Time.now.utc.to_date.month) - (start_date.year * 12 + start_date.month)
    months / 12
  end

  # Retrieve YAML descriptions, if a value is nil or the file cant be retrieved return 'Description unavailable...'
  def get_description(page, section)
    begin
      descriptions = YAML.load(File.read("#{Rails.root}/descriptions.yml"))
      if descriptions[page][section] != nil && descriptions[page][section] != ""
        return descriptions[page][section]
      else
        return "Description unavailable..."
      end
    end
  rescue
    return "Descriptions unavailable..."
  end
end
