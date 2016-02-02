require 'rb-readline'
require 'readline'

module ReadlineHelper
  def self.readline prompt, completions=[]
    # Store the state of the terminal
    RbReadline.clear_history
    if completions.length > 0
      completions.each {|i| Readline::HISTORY.push i}
      RbReadline.rl_completer_word_break_characters = ''
      Readline.completion_proc = proc { |s| completions.grep(/#{Regexp.escape(s)}/) }
      Readline.completion_append_character = ''
    end
    Readline.readline(prompt, false)
  end
end
