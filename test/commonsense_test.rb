require 'test_helper'

class CommonsenseTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Commonsense::VERSION
  end

  def test_valid_texts
    # trivial texts
    assert ::Commonsense::valid? ""

    # single-line headings
    assert ::Commonsense::valid? "writing"
    assert ::Commonsense::valid? "Protest"
    assert ::Commonsense::valid? "writing against"
    assert ::Commonsense::valid? "Protest against"

    # single-line sentences
    assert ::Commonsense::valid? "Writing against government."
    assert ::Commonsense::valid? "Writing against government. Free talk is healthy."

    # multi-line texts
    assert ::Commonsense::valid? "writing\nagainst\n\ngovernment"
    assert ::Commonsense::valid? "Protest\n\nWriting against the government. Free talk is healthy.\n\norganization"

    # Edge-case texts
    assert ::Commonsense::valid? "I"
    assert ::Commonsense::valid? "I.\nA. A."
    assert ::Commonsense::valid? "You and I."
  end

  def test_bad_characters
    refute ::Commonsense::valid? "writing $ was bad"
    refute ::Commonsense::valid? "_"
    refute ::Commonsense::valid? "-"
    refute ::Commonsense::valid? "bad\r"
    refute ::Commonsense::valid? "bad\t"
  end

  def test_bad_words
    refute ::Commonsense::valid? "agitprop"
    refute ::Commonsense::valid? "Obtuse. Mutterings."
  end

  def test_bad_capitalization
    refute ::Commonsense::valid? "Bad Writing"
    refute ::Commonsense::valid? "bad Writing"
    refute ::Commonsense::valid? "bad writing."
    refute ::Commonsense::valid? "bAd"
    refute ::Commonsense::valid? "bAd."
  end

  def test_bad_capitalization
    refute ::Commonsense::valid? "Bad Writing"
    refute ::Commonsense::valid? "bad Writing"
    refute ::Commonsense::valid? "bad writing."
    refute ::Commonsense::valid? "bAd"
    refute ::Commonsense::valid? "bAd."
  end

  def test_bad_spacing
    refute ::Commonsense::valid? " bad space"
    refute ::Commonsense::valid? "bad space "
    refute ::Commonsense::valid? " Bad space."
    refute ::Commonsense::valid? "Bad space. "
    refute ::Commonsense::valid? "Bad  space."
    refute ::Commonsense::valid? "Bad space.  Bad."
    refute ::Commonsense::valid? "Bad  space.\n "
    refute ::Commonsense::valid? "Bad space.\n Bad."
  end

  def test_bad_periods
    refute ::Commonsense::valid? ".."
    refute ::Commonsense::valid? "Writing.."
  end

  def test_pronouns
    assert ::Commonsense::valid? "They protest."
  end

  def test_conjugations
    assert ::Commonsense::valid? "I came. I saw. I took."
  end

  def test_wordlist_duplicates
    basic        = ::Commonsense::BasicEnglish::BASIC_WORDS
    pronouns     = ::Commonsense::BasicEnglish::PRONOUNS
    conjugations = ::Commonsense::BasicEnglish::CONJUGATIONS

    assert basic.detect { |e| basic.count(e) > 1 }.nil?
    assert pronouns.detect { |e| pronouns.count(e) > 1 }.nil?
    assert conjugations.detect { |e| conjugations.count(e) > 1 }.nil?

    assert ( basic & pronouns ).empty?
    assert ( basic & conjugations ).empty?
    assert ( pronouns & conjugations ).empty?
  end
end
