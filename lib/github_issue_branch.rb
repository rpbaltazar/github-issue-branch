require 'github_api'
require 'yaml'

class GithubIssueBranch

  module Error
    class AuthFileNotFound < StandardError
      def message
        "No auth file was found. Please create an auth token on github and store it under #{GITHUB_TOKEN_FILE[0]} or #{GITHUB_TOKEN_FILE[1]}"
      end
    end
  end

  GITHUB_TOKEN_FILE = ['.github_issue_branch_auth', "#{ENV['HOME']}/.github_issue_branch_auth"]

  def initialize
    @github_conf = YAML.load_file github_issue_branch_auth
    @github = Github.new(oauth_token: load_token)
  end

  def list_issues
    #@github
    # fetch open issues from github and print the name
  end

  def choose_issue issue_id
    # assign issue to me
    # create branch locally from current branch with name normalization-issue_id
  end

  private

  def github_auth_file
    conf_file = GITHUB_AUTH_FILE.select { |conf_file| File.exists? conf }.first
    raise Error::AuthFileNotFound unless conf_file
    conf_file
  end
end
