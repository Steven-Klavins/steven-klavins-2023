class Blog < ApplicationRecord
  validates_presence_of :title, :body
  validates :title, length: { maximum: 60 }

  has_many :blogs_categories
  has_many :categories, through: :blogs_categories
  has_one_attached :cover_image, dependent: :destroy

  has_rich_text :body
  paginates_per 5
end
