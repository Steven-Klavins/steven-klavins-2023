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

  # UI
  paginates_per 5
end
