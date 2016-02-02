require 'github_api'
require 'yaml'
require 'pry'
require_relative './github_issue_branch/readline_helper'

class GithubIssueBranch

  module Error

    class AuthFileNotFound < StandardError
      def message
        "No auth file was found. Please create an auth token on github and store it under #{GITHUB_TOKEN_FILE[0]} or #{GITHUB_TOKEN_FILE[1]}"
      end
    end

    class NoIssuesAvailable < StandardError
      def message
        # TODO: Load those from the configuration
        username = 'intelllex'
        repo = 'integrated'
        "No open issues were found in #{username}/#{repo}"
      end
    end

    class IssueNotFound < StandardError
      def message
        "The chosen issue was not found"
      end
    end

  end

  GITHUB_CONF_FILE = ['.github_issue_branch_auth', "#{ENV['HOME']}/.github_issue_branch_auth"]

  def initialize
    @github_conf = YAML.load_file github_auth_file
    @github = Github.new(oauth_token: @github_conf)
  end

  def get_issue_list
    # TODO: read this from either config file or from git remotes
    list = @github.issues.list user: 'intelllex', repo: 'integrated'
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

  def github_auth_file
    conf_file = GITHUB_CONF_FILE.select { |conf_file| File.exists? conf_file }.first
    raise Error::AuthFileNotFound unless conf_file
    conf_file
  end

  def issue_matcher issue, selection
    m = selection.match(/^(\d*) /)
    return false unless m
    id = m.captures.first
    return issue.number.to_s == id
  end
end
