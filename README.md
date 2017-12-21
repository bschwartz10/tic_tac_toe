# Tic Tac Toe

## Overview
This app is a command line version of the popular childhood game Tic Tac Toe

### Dependencies
  * This app uses the built in Ruby StringIO library and minitest for its testing library.
  * This app uses the [OStreamCatcher](https://github.com/codegourmet/o_stream_catcher) external library to hide output streams for testing

#### Note about I/O streams for testing
For a lot of my tests I am stubbing input from the user and hiding output from the console. An example of this is:

```ruby
string_io = StringIO.new #new instance of StringIO
string_io.puts '0' #Stub user input of 0
string_io.rewind #Start form first stub
$stdin = string_io #Override Ruby's standard input to new string_io
result, stdout, stderr = OStreamCatcher.catch do #hide/store stdout using OStreamCatcher gem
  player.turn(board) #call method
end
$stdin = STDIN #reset Ruby's standard input
```

### Setup
To run this project, perform the following:
  1. `cd` into the project's directory
  2. `cd` into the ruby folder
  3. run `bundle install` to install all dependencies
  4. Play a game by typing `ruby lib/start_game.rb`
  5. Three rake commands have been set up to run the tests
     - `rake tests` - Run all tests
     - `rake public_tests` - Run all public tests
     - `rake private_tests` - Run all private tests
  6. Individual public test files can be ran with `ruby test/public/file_name.rb`
  7. Individual private test files can be ran with `ruby test/private/file_name.rb`

### Design
The app is split into six separate classes and one module:
* AI - Holds logic for AI moves
* Board - represents a board for a single game
* Game - Holds methods to simulate a game
* Player - Holds logic for a human player turn
* Rules - Holds logic to determine end of game
* Settings - Dynamically creates game settings based on user input
* Io(module) - Houses I/O functionality

### Discussion
My goal was to keep the application simple while maintaining future flexibility. The first steps I took when diving into the application was to split the current working methods into individual classes and add tests to increase maintainability. From there, I added the requested features and polished the UI to create a friendly interface.

To increase the computer difficulty from "medium" to "hard" I implemented the negamax algorithm.

I decided to create a Settings class to dynamically generate the game settings based on user input. The Settings and Game class are closely coupled to each other but I decided to keep them separate for organizational reasons. The Settings class holds all the methods to prepare a game. The game class holds all the methods during the game and interacts directly with the game_settings hash on the Settings instance.

In this iteration I am testing my private methods using the .send method. I know there are opinions about this topic and wanted to acknowledge that I am open to testing or not testing my private methods. I chose to separate the methods into public and private folder to eliminate overlap.

I created an Io module to house all the I/O logic for the app. I include the module in the classes that require it. I chose to do this to encapsulate the logic and create reusable methods.
