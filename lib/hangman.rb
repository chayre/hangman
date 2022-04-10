# frozen_string_literal: true

require 'json'
require 'io/console'
require 'date'
require 'fileutils'
require_relative 'game_logic'
require_relative 'io_logic'

# Play the hangman game
class Hangman
  include GameLogic
  include Saving
  include Loading

  attr_accessor :round, :solution, :misses, :hits

  def initialize(round = 0, solution = "", misses = [], hits = [])
    @round = round
    @solution = solution
    @misses = misses
    @hits = hits
    @misses = [] if @misses.nil?
    @hits = [] if @hits.nil?
    @saved = false
    ask_load if @misses.length.zero? && @hits.length.zero?
    play
  end

  # Show game state and query user
  def game_state
    puts
    puts "Round #{@round}"
    puts "The codeword is displayed below. It has #{@solution.length} letters. You've have #{8 - @misses.length} guesses left until you lose."
    puts "Hits: #{@hits}"
    puts "Misses: #{@misses}"
    puts
    puts underscore_word(@hits)
    puts
    puts 'Enter your guess (a single letter). Enter 1 to save your current game.'
    puts
  end

  def play
    @solution = select_word if @round == 0
    while game_on?
      game_state
      take_input
      @round += 1
    end
  end
end
