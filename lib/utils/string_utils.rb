class StringUtils
  def self.branch_sanitize issue_title, issue_id
    sane_branch = "#{sanitize issue_title}-#{issue_id}"
  end

  def self.sanitize string
    sanitized = string.strip
    sanitized.downcase!
    sanitized.gsub!(/[`~!@#\$%^*()_+\-=\[\]\{\}\|\\'";:\?<>,.]/,'')
    sanitized.gsub!(/[&\/]/,' ')
    sanitized.gsub!(/\s+/, ' ')
    sanitized.gsub!(' ', '-')
    sanitized
  end
end
