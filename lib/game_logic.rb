# Frozen_string_literal: true
require_relative 'io_logic'

# Module which defines logic behind the hangman game
module GameLogic
  include Saving
  include Loading

  # Ask the user if they would like to load game, call load_save if they enter 1
  def ask_load
    puts 'To load a saved game enter 1. Press any other key to continue with a new game.'
    input = $stdin.gets.chomp
    load_save if input == '1'
  end 

  # Choose a random word from the dictionary
  def select_word
    possible_word = File.open('english_dictionary.txt') do |file|
      file.readlines.filter { |word| word.chomp.length.between?(6, 12) }
    end
    possible_word.sample.chomp
  end

  # Converts contents of solution word to underscore form (except for letters the player has correctly guessed)
  def underscore_word(hits)
    underscore = @solution.split("").map { |letter| hits.include?(letter) ? ' ' + letter + ' ' : ' _ ' }
    underscore.join
  end

  # Compare the user input with the solution
  def compare(letter)
    if @solution.split('').include?(letter)
      @hits.push(letter)
    else
      @misses.push(letter)
    end
  end

  # Get user input, keep asking until it is a letter (not yet submitted) or the numbers 1 or 2. Calls compare on the input
  def take_input
    input = $stdin.gets.chomp.downcase
    until (input.length == 1 && input.match?(/[[:alpha:]]/) && !@hits.include?(input) && !@misses.include?(input)) || input == '1'
      puts 'Try again.'
      input = $stdin.gets.chomp.downcase
    end
    save_game if input == '1'
    compare(input)
  end

  # True until the number of unique characters matches the number of hits or the player runs out of misses
  def game_on?
    if @solution.split('').uniq.length == @hits.length && @hits.length > 1
      puts "You win! The word was #{@solution}."
      false
    elsif @misses.length > 7
      puts "You lose! The word was #{@solution}."
      false
    elsif @saved
      puts 'Game saved. Exiting.'
      false
    elsif @loaded
      puts 'Your loaded game is complete. Exiting.'
      false
    else
      true
    end
  end
end
