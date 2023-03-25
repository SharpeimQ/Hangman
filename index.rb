# frozen_string_literal: true

dictionary = File.open('google-10000-english-no-swears.txt')
dictionary = dictionary.read.split.select { |word| word.length.between?(5, 12) }

# Game Algorithm for Hangman
class Hangman
  # Random term when object is initialized
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_term = dictionary.sample
    @lives_left = 7
    @guessed_terms = []
    @guessing_platform = []
    puts @secret_term
  end

  def game
    puts 'Welcome to Hangman! Guess the Missing Term!'
    status_display
    term_display
  end

  def term_display
    @secret_term.length.times do
      @guessing_platform << '___'
    end
    puts @guessing_platform.join(' ')
    insert_stars
  end

  def status_display
    puts "You Have #{@lives_left} Lives Left!"
    puts "Guessed:#{@guessed_terms}"
    insert_stars
  end

  def insert_stars
    puts '*******************************************'
    puts '*******************************************'
  end
end

Hangman.new(dictionary).game
