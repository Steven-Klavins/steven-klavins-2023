class Blog < ApplicationRecord
  has_rich_text :body
  has_one_attached :cover_image, dependent: :destroy
end
