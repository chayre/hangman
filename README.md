# Hangman
This command-line application is an implementation of Hangman written in Ruby.
## Initialization
The game begins by opening an english_dictionary.txt file and sampling a random word between 6 and 12 characters. The word is saved as the keyword, then converted into "underscore form":
>  "verizon "
>  
  becomes  
>  "_ _ _ _ _ _ _"

## Player Interaction

Next, the player is queried for a guess. The guess is checked as valid (a character) and then compared against the list of previous guesses (stored in hits and misses arrays) to check for uniqueness. If the player guesses correctly, their guess is added to the hits array and the word's "underscore form" is altered to restore each instance of the correctly guessed letter. Otherwise, their guess is added to the misses array and the number of guesses reamining is decreased by one. In either case, the round is incremented by one. See the preview images below as an example. The game ends when the player has run out of guesses or has correctly guessed each letter in the word.

## Saving/Loading Games

As an added feature, the player has the option of loading a previously saved game when starting the script, or saving their current game after each round. Saving works by saving the state of each game variable into a .json file, named via timestamp, then saving it to a saves directory. Loading works by entering the saves directory and allowing the player to select which .json to import. 

## Directions

To run this application, install ruby, navigate to the project's directory, and enter "ruby lib/main.rb"

## Demo
### Playing the game

![image](https://user-images.githubusercontent.com/88121502/165216950-fe7ab29e-1815-4a6d-a133-8123c5c51d04.png)

### Loading a saved game

![image](https://user-images.githubusercontent.com/88121502/165217086-f8e24df7-cb51-4f90-9c6c-446864b79f6c.png)
