class AddCompanyUrlToExperiences < ActiveRecord::Migration[7.0]
  def change
    add_column :experiences, :company_url, :string
  end
end
