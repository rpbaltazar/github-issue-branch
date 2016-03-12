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
    git = OpenStruct.new(
      {
        remotes: [
          remote_origin
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
    end
  end
end
