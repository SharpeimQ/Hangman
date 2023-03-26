# frozen_string_literal: true

dictionary = File.open('google-10000-english-no-swears.txt')
dictionary = dictionary.read.split.select { |word| word.length.between?(5, 12) }

# Game Algorithm for Hangman
class Hangman
  # object is initialized
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_term = dictionary.sample.upcase.split('')
    @lives_left = 7
    @guessed_letters = []
    @guessing_platform = []
    puts @secret_term.inspect
  end

  def game
    intro_dialogue
    until @lives_left == 5 || @guessing_platform == @secret_term
      display
      user_prompt
    end
  end

  # Display Methods
  def display
    status_display
    term_display
  end

  def term_display
    puts @guessing_platform.join(' ')
    insert_stars
  end

  def status_display
    puts "You Have #{@lives_left} Lives Left!"
    puts "Guessed:#{@guessed_letters}"
    insert_stars
  end

  def insert_stars
    puts '*****************************************************'
    puts '*****************************************************'
  end

  def intro_dialogue
    puts '*****************************************************'
    puts '**********************HANGMAN************************'
    puts '*****************************************************'
    @secret_term.length.times do
      @guessing_platform << '___'
    end
  end

  # User Prompt Methods
  def user_prompt
    puts 'Enter a letter A-Z!'
    guess = gets.chomp.upcase
    promp_check(guess)
    resulting(guess)
  end

  def resulting(guess)
    if @secret_term.include?(guess)
      @secret_term.each_index do |letter|
        @secret_term[letter] == guess ? @guessing_platform[letter] = guess : @guessing_platform
      end
      @guessed_letters.include?(guess) ? @guessed_letters : @guessed_letters << guess
    else
      @guessed_letters << guess
      @lives_left -= 1
    end
  end

  def promp_check(guess)
    until guess.length == 1 && guess.match?(/^[a-zA-Z]+$/) && @guessed_letters.include?(guess) == false
      puts 'Enter a letter A-Z!'
      guess = gets.chomp.upcase
    end
  end
end

Hangman.new(dictionary).game
