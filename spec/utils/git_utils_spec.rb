require_relative '../../lib/utils/git_utils.rb'
require 'ostruct'
require 'minitest/autorun'
require 'pry'

module Git
  def self.open path
    remote_origin = OpenStruct.new(
      {
        name: 'origin',
        url: 'git@github.com:rpbaltazar/github-issue-branch.git'
      }
    )
    remote_heroku = OpenStruct.new(
      {
        name: 'heroku',
        url: 'https://github.com/seattlerb/minitest.git'
      }
    )
    git = OpenStruct.new(
      {
        remotes: [
          remote_origin,
          remote_heroku
        ]
      }
    )
    git
  end
end

describe GitUtils do
  describe 'get_remote by name' do
    it 'fetches the remote from git' do
      remote = GitUtils.get_remote 'origin'
      remote.name.must_equal 'origin'
      remote.url.must_equal 'git@github.com:rpbaltazar/github-issue-branch.git'

      # TODO: Throw error if remote name not found
    end
  end

  describe 'get_remote_url' do
    it 'fetches the remote url from git' do
      url = GitUtils.get_remote_url 'origin'
      url.must_equal 'git@github.com:rpbaltazar/github-issue-branch.git'
    end
  end

  describe 'get_remote_user_repo' do
    it 'fetches the repository owner and repository name' do
      repo_owner, repo_name = GitUtils.get_remote_user_repo 'origin'
      repo_owner.must_equal 'rpbaltazar'
      repo_name.must_equal 'github-issue-branch'

      repo_owner, repo_name = GitUtils.get_remote_user_repo 'heroku'
      repo_owner.must_equal 'seattlerb'
      repo_name.must_equal 'minitest'
    end
  end
end
