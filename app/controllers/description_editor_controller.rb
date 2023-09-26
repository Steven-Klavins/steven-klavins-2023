class DescriptionEditorController < ApplicationController
  require 'yaml'
  require 'httparty'
  include DescriptionEditor

  before_action :authenticate_user!

  FAIL_DESCRIPTION = "Failed to update yaml and commit to GitHub, please review the application logs.
                      Remember to check weather or not your Github token is still valid."

  def update_yaml_description
    if current_user
      # Extract params from update form.
      updated_description = description_form_params[:description]
      page = description_form_params[:page]
      section = description_form_params[:section]

      # Update the file and write it locally, returns true if sucessful.
      local_update_successful = DescriptionEditor.update_local_yaml(updated_description, page, section)

      # Once the local file is updated commit it to GitHub.
      # DO NOT COMMIT CHANGES TO THE REPO IN DEVELOPMENT.
      if local_update_successful && Rails.env.production?
        response = DescriptionEditor.commit_description_changes(ENV['REPO_URL'], 'steven-klavins-site-descriptions.yml')

        if response
          redirect_to request.referrer
        else
          NotificationMailer.new_notification("YAML description update failed!", FAIL_DESCRIPTION).deliver_later
          render json: { success: false }
        end
      else
        # If we are in development just update the page.
        redirect_to request.referrer
      end
    end
  end

  private

  def description_form_params
    params.permit(:description, :page, :section, :authenticity_token, :commit)
  end
end