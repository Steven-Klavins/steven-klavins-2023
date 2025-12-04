class HomeController < ApplicationController
  def index
    @experiences = Experience.order(start_date: :desc).includes(company_logo_attachment: [:blob])
  end
end
