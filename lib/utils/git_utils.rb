require 'git'

class GitUtils
  def self.g
    Git.open '.'
  end

  def self.get_remote name
    g.remotes.select {|remote| remote.name == name}.first
  end

  def self.get_remote_url name
    get_remote(name).url
  end

  def self.get_remote_user_repo name
    url = get_remote_url(name)
    repo_owner_name = /.*github.com[:|\/](.*).git/.match(url).captures
    repo_owner_name.first.split '/'
  end

  def self.create_branch name
    # TODO: Throw error if branch already exists either locally or remotely
    g.branch(name).checkout
  end
end
