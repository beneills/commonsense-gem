require "commonsense/basic_english"
require "commonsense/version"

module Commonsense

  HEADING_START_CODEPOINTS = "a-zA-Z0-9"
  HEADING_BODY_CODEPOINTS  = "a-zA-Z0-9 "
  HEADING_END_CODEPOINTS   = "a-zA-Z0-9"

  SENTENCE_START_CODEPOINTS = "A-Z0-9"
  SENTENCE_BODY_CODEPOINTS  = "a-zA-Z0-9 "
  SENTENCE_END_CODEPOINTS   = "a-zA-Z0-9"

  SPACE_CODEPOINT           = " "
  PERIOD_CODEPOINT          = "\\."
  NEWLINE_CODEPOINT         = "\n"

  LINE_WHITELIST            = "a-zA-Z0-9 \\."
  TEXT_WHITELIST            = "a-zA-Z0-9 \\.\n"

  ##
  # Tests whether line conforms to the commonsense specification of a line.
  #
  # +line+ should be a UTF-8 encoded Ruby string with no newline characters.

  def self.valid_line?(line)

      # line should be UTF-8 encoded
      raise ArgumentError, 'line not UTF-8 encoded'    unless line.encoding == Encoding::UTF_8
      raise ArgumentError, 'line has invalid encoding' unless line.valid_encoding?

      # line should contain only whitelisted codepoints
      return false unless /^[#{LINE_WHITELIST}]*$/.match line

      # a line should be:
      #   i)  a bare heading, or
      #   ii) a single-space-separated list of period-terminated sentences
      heading                    = "[#{HEADING_START_CODEPOINTS}]([#{HEADING_BODY_CODEPOINTS}]*[#{HEADING_END_CODEPOINTS}])?"
      sentence                   = "[#{SENTENCE_START_CODEPOINTS}]([#{SENTENCE_BODY_CODEPOINTS}]*[#{SENTENCE_END_CODEPOINTS}])?#{PERIOD_CODEPOINT}"
      sentences                  = "(#{sentence}#{SPACE_CODEPOINT})*#{sentence}"
      return false unless /^#{heading}$/.match line or /^#{sentences}$/.match line

      # we must never have two spaces in a row
      return false if /(#{SPACE_CODEPOINT}#{SPACE_CODEPOINT}+)/.match line

      # split heading or sentence line into indidicual sentences
      sentences = line.split(".").map { |sentence| sentence.split SPACE_CODEPOINT }

      sentences.each do |sentence|
        # first word of each sentence/heading should be in wordlist, possibly with de-capitalization
        return false unless Commonsense::BasicEnglish.fuzzy_valid? sentence.first

        # other words should be in wordlist as-is
        return false unless sentence[1..-1].all? { |word| Commonsense::BasicEnglish.valid? word }
      end

      # if the text passes all the above, it conforms to the spec
      return true
  end

  ##
  # Tests whether text conforms to the commonsense specification of a multi-line text.
  #
  # +text+ should be a UTF-8 encoded Ruby string.

  def self.valid?(text)

    # text should be UTF-8 encoded
    raise ArgumentError, 'text not UTF-8 encoded'    unless text.encoding == Encoding::UTF_8
    raise ArgumentError, 'text has invalid encoding' unless text.valid_encoding?

    # text should contain only whitelisted codepoints
    return false unless /^[#{TEXT_WHITELIST}]*$/.match text

    # text should be a sequence of zero or more lines
    return text.split(NEWLINE_CODEPOINT).all? { |line| line.empty? or valid_line? line }
  end

end
