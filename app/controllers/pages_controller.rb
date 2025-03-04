class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:admin_panel]

  def home
    @experiences = Experience.order(created_at: :desc).includes(company_logo_attachment: [:blob])
  end

  def contact
  end

  def about
  end

  def thanks
  end

  def admin_panel
  end
end
