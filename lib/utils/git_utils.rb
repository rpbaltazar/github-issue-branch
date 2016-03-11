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

  # TODO: Use regex to extract values instead?
  def self.get_remote_user_repo name
    url = get_remote_url(name)
    username_repository = url.split(':')[1]
    username_repository.slice! '.git'
    username_repository.split '/'
  end

  def self.create_branch name
    # TODO: Throw error if branch already exists either locally or remotely
    g.checkout name
  end
end
