class Category < ApplicationRecord
  has_many :blogs_categories
  has_many :blogs, through: :blogs_categories
  validates_presence_of :name
  validates :name, uniqueness: true
end
