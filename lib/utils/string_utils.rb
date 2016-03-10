class StringUtils
  def self.branch_sanitize issue_title, issue_id
    sane_branch = "#{sanitize issue_title}-#{issue_id}"
  end

  def self.sanitize string
    string.strip!
    string.gsub!(/^.*(\\|\/)/, '')
    string.gsub!(/[^0-9A-Za-z.\-]/, '-')
    string.gsub!(' ', '-')
    string
  end
end
