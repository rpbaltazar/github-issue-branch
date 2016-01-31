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

  GITHUB_CONF_FILE = ['.github_issue_branch_auth', "#{ENV['HOME']}/.github_issue_branch_auth"]

  def initialize
    @github_conf = YAML.load_file github_auth_file
    @github = Github.new(oauth_token: @github_conf)
  end

  def list_issues
    # TODO: read this from either config file or from git remotes
    list = @github.issues.list user: 'intelllex', repo: 'integrated'
    @issue_list = list.select { |issue| issue['pull_request'].nil? }
    print_list
  end

  def choose_issue issue_id
    # assign issue to me
    # create branch locally from current branch with name normalization-issue_id
  end

  def print_list
    @issue_list.each { |issue| puts issue.title }
  end

  private

  def github_auth_file
    conf_file = GITHUB_CONF_FILE.select { |conf_file| File.exists? conf_file }.first
    raise Error::AuthFileNotFound unless conf_file
    conf_file
  end
end
