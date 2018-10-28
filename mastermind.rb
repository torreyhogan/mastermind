require_relative 'player.rb'
require_relative 'computer.rb'

def choose_game
	puts "Welcome to Mastermind"
	puts "Would you like to play a against a player or a computer?: "
	game_type = gets.chomp

	player_game = Player.new(12)
	player_game.play