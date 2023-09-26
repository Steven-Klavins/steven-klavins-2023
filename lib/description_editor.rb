module DescriptionEditor
  # Updated a description in the locally stored YAML.
  def self.update_local_yaml(updated_description, page, section)
    descriptions = YAML.load_file('descriptions.yml')

    if [updated_description, section, page].any?(&:nil?) || descriptions.dig(page, section).nil?
      return false
    else
      descriptions[page][section] = updated_description
      File.open('descriptions.yml', 'w+') { |f| f.write(descriptions.to_yaml) }
      YAML.load_file('descriptions.yml')
      return true
    end
  end

  # Commit changes to the git repo
  def self.commit_description_changes(repo_url, file_path)

    sha_value = self.get_file_sha(repo_url, file_path)
    up_to_date_yaml = File.read('descriptions.yml')

    response = HTTParty.put("#{repo_url}/contents/#{file_path}",
                            headers: {
                              'Authorization' => "Bearer #{ENV['GIT_ACCESS_TOKEN']}",
                              'Content-Type' => 'application/json'
                            },
                            body: {
                              path: file_path,
                              message: 'update descriptions',
                              content: Base64.encode64(up_to_date_yaml),
                              branch: 'main',
                              sha: sha_value
                            }.to_json)

    if response.success?
      return true
    else
      return false
    end
  end

  # Get current SHA value for the descriptions repo so we can commit in commit_description_changes
  def self.get_file_sha(repo_url, file_path)
    # Retrieve the Tree URL for the given branch and parent directory path
    tree_url = "#{repo_url}/contents/#{file_path}"

    response = HTTParty.get(tree_url, headers: {
      'Authorization' => "Bearer #{ENV['GIT_ACCESS_TOKEN']}",
      'Content-Type' => 'application/json'
    })

    tree = JSON.parse(response.body)
    tree['sha']
  end
end