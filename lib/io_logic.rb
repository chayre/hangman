# Frozen_string_literal: true

# Modules for loading JSON files
module Loading
  # Open the file and read the lines, then pass to from_json
  def load_save
    @saves = Dir['./saves/*'].map { |name| name[8..-1] }
    save = select_save
    File.open(save, 'r') do |file|
      from_json(file)
    end
  end

  # Display list of saves and prompt user selection
  def select_save
    puts 'Enter the number corresponding to your save.', 'Your saves:'
    @saves.each_with_index { |save, index| puts "#{index+1}: #{save}" }
    input = gets.chomp.to_i
    select_save unless input.positive? && input.to_s.length == 1
    "./saves/#{@saves[input - 1]}"
  end

  # Use JSON.parse to parse the lines given to it; create a new Hangman game using the data fields
  def from_json(string)
    data = JSON.parse(File.read(string))
    @loaded = true
    Hangman.new(data['round'], data['solution'], data['misses'], data['hits'])
  end
end

# Module for saving JSON files
module Saving
  # Dump current values to JSON
  def to_json(*)
    JSON.dump({
                round: @round,
                solution: @solution,
                misses: @misses,
                hits: @hits
    })
  end

  # Create save directory if it doesn't exist, create file, dump JSON
  def save_game
    save_name = 'HangmanSave' + DateTime.now.to_s
    unless Dir.exist?("./saves/")
      FileUtils.mkdir_p("./saves/")
    end
    @path = "./saves/#{save_name}.json"
    File.open(@path, 'w') do |file|
      JSON.dump(self, file)
    end
    @saved = true
  end
end
