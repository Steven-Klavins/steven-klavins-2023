require 'httparty'

# Retrieve the most up to date copy of the site descriptions YAML
# These are located in a private GitHub repo, the reason for this is to ensure description changes
# are checked into version control.

Rails.application.config.before_initialize do
  if Rails.env.production?
    # Note the GitHub access token expires, remember to update this when needed to comply with GitHub's security measures.
    GIT_ACCESS_TOKEN = ENV['GIT_ACCESS_TOKEN']
    REPO_URL = ENV['REPO_URL']
    FILE_PATH = 'steven-klavins-site-descriptions.yml'

    FAIL_DESCRIPTION = "Failed to fetch YAML descriptions for stevenklavins.co.uk.
                        Note: The GitHub the access token expires, remember to update this when needed to
                        comply with GitHub's security measures."

    # Retrieve the most up to date copy of the site descriptions YAML
    response = HTTParty.get("#{REPO_URL}/contents/#{FILE_PATH}",
                            headers: {
                              'Authorization' => "Bearer #{GIT_ACCESS_TOKEN}",
                              'Content-Type' => 'application/json'
                            })

    # If successful write the updated YAML to descriptions.yml
    # Else notify there was an issue.

    if response.success?
      file_content = Base64.decode64(response['content'])
      File.open("descriptions.yml", "w") do |f|
        f.write(file_content)
      end
      puts "Successfully retrieved #{FILE_PATH}"
    else
      NotificationMailer.new_notification("Failed to fetch YAML descriptions", FAIL_DESCRIPTION).deliver_later
      puts 'Failed to fetch YAML descriptions!'
    end
  else
    # If we are in development or test don't fetch descriptions from github, use the local sample yml.
    File.open("descriptions.yml", "w") do |output|
      File.open(Rails.root.join('spec', 'fixtures', 'sample-descriptions.yml')) do |input|
        output.write(input.read())
      end
    end
  end
end