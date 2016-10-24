require 'set'

class WordChainer
  attr_reader :dictionary, :current_words, :all_seen_words

  def initialize(dictionary_path)
    @dictionary = Set.new(File.readlines(dictionary_path).map(&:chomp))
    @current_words = Set.new
    @all_seen_words = {}
  end

  def adjacent_words word
    match_length = @dictionary.select{|w| w.length == word.length}

    reg_exp = []
    word.each_char.with_index do |letter, i|
      reg_word = word.dup
      reg_word[i] = '.'

      reg_exp << reg_word
    end

    reg_exp = reg_exp.join('|')

    match_length.select { |w| w[/#{reg_exp}/] }
  end

  def run(source, target)
    @current_words << source
    @all_seen_words[source] = nil

    until @current_words.include?(target)
      new_current_words = explore_current_words

      @current_words = new_current_words
    end
  end

  def explore_current_words
    new_current_words = Set.new

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)

        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end

    p @all_seen_words.select{|k, _| new_current_words.include?(k)}
    puts 'end'

    new_current_words
  end

  def build_path target
    path = []

    source = target
    until source.nil?
      path << source
      source = @all_seen_words[source]
    end

    path
  end
end
