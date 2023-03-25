# frozen_string_literal: true

dictionary = File.open('google-10000-english-no-swears.txt')
dictionary = dictionary.read.split.select { |word| word.length.between?(5, 12) }

# Game Algorithm for Hangman
class Hangman
  # Random term when object is initialized
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_term = dictionary.sample
    puts @secret_term
  end

  def game
    puts 'Welcome to Hangman! Guess the Missing Term!'
    status_display
    term_display
  end

  def term_display
    guessing_platform = []
    @secret_term.length.times do
      guessing_platform << '_'
    end
    puts guessing_platform.join(' ').inspect
    insert_dashes
  end

  def status_display
    guessed_terms = []
    lives_left = 7
    puts "You Have #{lives_left} Lives Left!"
    puts "Guessed:#{guessed_terms}"
    insert_dashes
  end

  def insert_dashes
    puts '-------------------------------------------'
    puts '-------------------------------------------'
  end
end

Hangman.new(dictionary).game
