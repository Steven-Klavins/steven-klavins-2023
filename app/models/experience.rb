class Experience < ApplicationRecord
  has_one_attached :company_logo, dependent: :destroy
  validates_presence_of :company, :position, :description, :start_date, :end_date
  validates :company_logo, presence: true

end
