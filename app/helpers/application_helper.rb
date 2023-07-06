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
end
