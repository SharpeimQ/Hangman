# frozen_string_literal: true

require 'yaml'

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
  end

  def game
    intro_dialogue
    until @lives_left.zero? || @guessing_platform == @secret_term
      display
      user_prompt
      save_request
    end
    game_outcome
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
    puts 'Press Y if you want to play on a previous save!'
    @secret_term.length.times do
      @guessing_platform << '___'
    end
    yes = gets.chomp.upcase
    yes == 'Y' ? load_game('save.yml') : nil
  end

  # User Prompt Methods
  def user_prompt
    puts 'Enter a letter A-Z!'
    guess = gets.chomp.upcase
    guess = prompt_check(guess)
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

  def prompt_check(guess)
    until guess.length == 1 && guess.match?(/^[a-zA-Z]+$/) && @guessed_letters.include?(guess) == false
      puts 'Enter a letter A-Z!'
      guess = gets.chomp.upcase
    end
    guess
  end

  # End Result Method
  def game_outcome
    p @guessing_platform.join('')
    if @lives_left.zero?
      puts '*****************************************************'
      puts '**********************LOSER*************************'
      puts '*****************************************************'
    elsif @guessing_platform == @secret_term
      puts '*****************************************************'
      puts '******************CONGRATULATIONS********************'
      puts '*****************************************************'
    end
  end

  # Save File Methods
  def save_request
    valid_choices = %w[Y N]
    puts 'Do you want to save your game? (Y/N)'
    yes_no = gets.chomp.upcase
    until valid_choices.include?(yes_no)
      puts 'Do you want to save your game? (Y/N)'
      yes_no = gets.chomp.upcase
    end
    yes_no == 'Y' ? save_game('save.yml') : nil
  end

  def save_game(filename)
    data = {
      secret_term: @secret_term,
      lives_left: @lives_left,
      guessed_letters: @guessed_letters,
      guessing_platform: @guessing_platform
    }
    File.write(filename, YAML.dump(data))
  end

  def load_game(filename)
    if File.exist?(filename)
      saved_data = YAML.load_file(filename)
      @secret_term = saved_data[:secret_term]
      @lives_left = saved_data[:lives_left]
      @guessed_letters = saved_data[:guessed_letters]
      @guessing_platform = saved_data[:guessing_platform]
    else
      puts 'No Current Saves'
    end
  end
end

Hangman.new(dictionary).game
