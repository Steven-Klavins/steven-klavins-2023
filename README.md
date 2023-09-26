# Steven Klavins 2023
<p>
  <a href="https://github.com/Steven-Klavins/steven-klavins-2023/actions"><img alt="typescript-action status" src="https://github.com/Steven-Klavins/steven-klavins-2023/workflows/CI/badge.svg"></a>
</p>

This repo contains my portfolio site for 2023

You can visit my website [here](https://stevenklavins.co.uk/)

## Technologies used
* [Ruby On Rails](https://rubyonrails.org/).
* [Sidekiq](https://github.com/sidekiq/sidekiq) and [Redis](https://redis.com/) for background jobs.
* [Javascript](https://www.javascript.com/) for UI components.
* [Docker](https://www.docker.com/) for containerization.
* [RSpec](https://rspec.info/) and [Capybara](https://github.com/teamcapybara/capybara) for unit/feature testing.
* [Devise](https://github.com/heartcombo/devise) for authorization.
* [Github Actions](https://github.com/features/actions) for continuous integration.
* [Digital Ocean](https://www.digitalocean.com) for hosting and deployment.

## Environment Variables
A number of environment variables are required to run the app in production. 
[Active Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html) is configured to
use [DigitalOcean Spaces](https://try.digitalocean.com/cloud-storage/) a storage solution compatible with the
[Ruby AWS SDK](https://github.com/aws/aws-sdk-ruby).

* **SPACES_ACCESS_KEY_ID** - Your Digital Ocean access key
* **SPACES_SECRET_ACCESS_KEY** - Your Digital Ocean secret key
* **SPACES_BUCKET_NAME** - The name of your selected bucket.
* **SPACES_ENDPOINT** - Your bucket's endpoint.

[Action Mailer's](https://guides.rubyonrails.org/action_mailer_basics.html) settings are configured to use 
[Gmail SMTP](https://developers.google.com/gmail/imap/imap-smtp), this requires generating an 
[App Password](https://support.google.com/accounts/answer/185833?hl=en.)

* **SMTP_PASSWORD** - Your SMTP app password
* **SMTP_EMAIL** - The email associated with the password.

In this project, site descriptions are checked into version control via the 
[GitHub API](https://docs.github.com/en/rest?apiVersion=2022-11-28).

* **GIT_ACCESS_TOKEN** - Your GitHub access token
* **REPO_URL** - The Repo URL where the descriptions YAML is checked in 
`https://api.github.com/repos/UserName/RepoName`
* **FILE_PATH** - The path to the descriptions file in the repo  
`some_folder/descriptions.yml`

Some of the more standard Rails stuff includes:

* **RAILS_MASTER_KEY** - Your Rails master key
* **DATABASE_URL** - Your database URL
* **REDIS_URL** - Your Redis URL

## How To Run

Set up the database and install the required dependencies.
```
bundle install 
rails db:setup
rails db:migrate 
```

**Run the Rails server and Sidekiq**

**Note:** Ensure you have you have a [Redis](https://redis.com/) service configured and running before proceeding to this step.
```
rails s
bundle exec sidekiq
```

## Testing

**To run tests use**
```
bundle exec rspec
```
