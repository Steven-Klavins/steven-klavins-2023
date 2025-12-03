class Experience < ApplicationRecord
  has_one_attached :company_logo, dependent: :destroy
  validates_presence_of :company, :position, :description, :start_date
  validates :company_logo, presence: true


  def ongoing?
    end_date.nil?
  end

  # Helper method to format dates for display
  def display_dates
    if ongoing?
      "#{start_date.strftime('%m/%Y')} - Present"
    else
      "#{start_date.strftime('%m/%Y')} - #{end_date.strftime('%m/%Y')}"
    end
  end
end
