# frozen_string_literal: true

dictionary = File.open('google-10000-english-no-swears.txt')
dictionary = dictionary.read.split.select { |word| word.length.between?(5, 12) }

# Game Algorithm for Hangman
class Hangman
  def initialize(dictionary)
    @dictionary = dictionary
    @unknown_term = dictionary.sample
    puts @unknown_term
  end
end

Hangman.new(dictionary)
