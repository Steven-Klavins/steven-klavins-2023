require 'httparty'
require 'description_editor'

describe DescriptionEditor do

  before(:context) do
    ENV['GIT_ACCESS_TOKEN'] = "access-token"
  end

  describe '.get_file_sha' do
    let(:repo_url) { 'https://api.github.com/repos/username/repo' }
    let(:file_path) { 'path/to/file.txt' }
    let(:access_token) { 'access-token' }
    let(:headers) do
      {
        'Authorization' => "Bearer #{access_token}",
        'Content-Type' => 'application/json'
      }
    end

    it 'should return the sha of the file' do
      # Stub the HTTP request
      response_body = { 'sha' => '1234567890' }.to_json
      allow(HTTParty).to receive(:get)
                           .with("#{repo_url}/contents/#{file_path}", :headers => headers)
                           .and_return(double(body: response_body))

      sha = DescriptionEditor.get_file_sha(repo_url, file_path)
      expect(sha).to eq('1234567890')
    end
  end

  describe '.update_local_yaml' do
    context 'when all parameters are provided' do
      it 'updates the YAML file and returns true' do
        updated_description = 'New description'
        page = 'Home'
        section = 'heading'

        result = DescriptionEditor.update_local_yaml(updated_description, page, section)
        expect(result).to eq(true)
        
        descriptions = YAML.load_file('descriptions.yml')
        expect(descriptions[page][section]).to eq(updated_description)
      end
    end

    context 'when any parameter is missing' do
      it 'returns false without modifying the YAML file' do
        updated_description = 'New description'
        page = 'example_page'
        section = nil
        result = DescriptionEditor.update_local_yaml(updated_description, page, section)
        expect(result).to eq(false)
      end
    end
  end
end
