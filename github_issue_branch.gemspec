Gem::Specification.new do |s|
  s.name = 'github_issue_branch'
  s.version = '0.0.0alpha'
  s.date = '2016-01-28'
  s.summary = 'Create branches from open issues'
  s.description = 'Check a list of open issues in a specific repository, assign it to you and get your branch created'
  s.authors = ['Rui Baltazar']
  s.email = 'rui.p.baltazar@gmail.com'
  s.files = ['lib/github_issue_branch.rb']
  s.executables << 'github_issue_branch'
  s.homepage = 'http://github.com/rpbaltazar/github-issue-branch'
  s.add_runtime_dependency 'github_api', '~> 0.13'
  s.license = 'MIT'
end
