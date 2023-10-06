class Blog < ApplicationRecord
  # Friendly ID
  extend FriendlyId
  friendly_id :title, use: %i(slugged history finders)

  # Validation
  validates_presence_of :title, :body
  validates :title, length: { maximum: 60 }

  # Relationships
  has_many :blogs_categories
  has_many :categories, through: :blogs_categories
  has_one_attached :cover_image, dependent: :destroy

  # UI
  has_rich_text :body
  paginates_per 10

  # Image optimization
  def cover_image_webp
    cover_image.variant(
      format: :webp,
      resize_to_limit: [1200, 1200],
      saver: {
        subsample_mode: "on",
        strip: true,
        interlace: true,
        lossless: false,
        quality: 80 }).processed
  end
end
