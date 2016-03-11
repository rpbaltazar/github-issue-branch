require_relative '../../lib/utils/string_utils.rb'
require 'minitest/autorun'

describe StringUtils do
  describe 'sanitize' do
    it 'converts a string into a dasherized git branch safe string' do
      test_string_array = [
        { title: 'User timeline', expectation: 'user-timeline' },
        { title: 'User profile - Certificates & qualifications', expectation: 'user-profile-certificates-qualifications' },
        { title: 'User Upvote/Downvote a post', expectation: 'user-upvote-downvote-a-post' },
        { title: 'Players & Staff - Adding&Removing Individuals', expectation: 'players-staff-adding-removing-individuals' },
      ]

      test_string_array.each do |test_combo|
        sanitized = StringUtils.sanitize(test_combo[:title])
        sanitized.must_equal test_combo[:expectation]
      end
    end
  end
end
