require 'github_api'
require 'yaml'
require 'pry'
require_relative './git_utils'

class GithubIssueBranch

  module Error

    class ConfNotFound < StandardError
      def message
        "Required configuration was not found in config files nor environment variables"
      end
    end

    class NoIssuesAvailable < StandardError
      def message
        "No open issues were found in #{@github_repo}"
      end
    end

    class IssueNotFound < StandardError
      def message
        "The chosen issue was not found"
      end
    end

  end

  GITHUB_CONF_FILE = ['.github_issue_branch_conf', "#{ENV['HOME']}/.github_issue_branch_conf"]

  def initialize
    load_configs
    @github = Github.new(oauth_token: @github_token)
  end

  def get_issue_list
    # TODO: read this from either config file or from git remotes
    list = @github.issues.list user: @github_username, repo: @github_repo
    list.select { |issue| issue['pull_request'].nil? }
  end

  def select_issue
    issue_list = get_issue_list
    raise Error::NoIssuesAvailable unless issue_list.length > 0
    print_list issue_list
    issue = choose_issue issue_list
    puts "Assigning issue to you"
    puts "git co -b #{issue}"
  end

  def choose_issue issue_list
    issue_selection = ReadlineHelper.readline('Select an issue: ', issue_list)
    return nil if issue_selection == '' or issue_selection.nil?
    issue = issue_list.select{|s| issue_matcher s, issue_selection }.first
    raise Error::IssueNotFound if issue.nil?
    return issue
  end

  def print_list issue_list
    issue_list.each { |issue| puts "#{issue.number} - #{issue.title}" }
  end

  private

  def load_configs
    @github_token = read_conf 'github_auth_token', 'GITHUB_AUTH_TOKEN'
    username, repo = GitUtils.get_remote_user_repo('origin')
    @github_username = read_conf('github_username') || username
    @github_repo = read_conf('github_repo') || repo
  end

  def read_conf(conf_name, environment_key=nil)
    GITHUB_CONF_FILE.each do |config_file|
      if File.exists? config_file
        configurations = YAML.load_file config_file
        return configurations[conf_name] if configurations[conf_name]
      end
    end

    if environment_key
      value ||= env_required environment_key
      value
    end
  end

  def env_required var_name
    raise Error::ConfNotFound if ENV[var_name].nil?
    ENV[var_name]
  end

  def issue_matcher issue, selection
    m = selection.match(/^(\d*) /)
    return false unless m
    id = m.captures.first
    return issue.number.to_s == id
  end
end
