require 'github_api'

class GithubIssueBranch
  def initialize
    @github = Github.new
    # init github config
  end

  def list_issues
    # fetch open issues from github and print the name
  end

  def choose_issue issue_id
    # assign issue to me
    # create branch locally from current branch with name normalization-issue_id
  end
end
