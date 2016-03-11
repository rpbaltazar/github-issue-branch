require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |s|
  s.name = 'github_issue_branch'
  s.version = GithubIssueBranch::VERSION
  s.date = Date.today.to_s
  s.summary = 'Create branches from open issues'
  s.description = 'Check a list of open issues in a specific repository, assign it to you and get your branch created'
  s.authors = ['Rui Baltazar']
  s.email = 'rui.p.baltazar@gmail.com'
  s.files = Dir['{lib}/**/*']
  s.require_paths = %w[ lib ]
  s.executables << 'github_issue_branch'
  s.homepage = 'http://github.com/rpbaltazar/github-issue-branch'
  s.add_runtime_dependency 'github_api', '~> 0.13'
  s.add_runtime_dependency 'git', '~> 1.3'
  s.license = 'MIT'
end
