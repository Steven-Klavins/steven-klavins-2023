class Category < ApplicationRecord
  # Friendly ID
  extend FriendlyId
  friendly_id :name, use: %i(slugged history finders)

  # Validation
  validates_presence_of :name
  validates :name, uniqueness: true

  # Relationships
  has_many :blogs_categories
  has_many :blogs, through: :blogs_categories
  has_one_attached :cover_image, dependent: :destroy

  # UI
  paginates_per 5

  # Image optimization
  def cover_image_webp
    cover_image.variant(
      format: :webp,
      resize_to_limit: [1500, 1500],
      saver: {
        subsample_mode: "on",
        strip: true,
        interlace: true,
        lossless: false,
        quality: 100 }).processed
  end
end
