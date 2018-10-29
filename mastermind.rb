require_relative 'player.rb'
require_relative 'computer.rb'

def choose_game
	puts "Welcome to Mastermind"
	puts "Would you like to be the guesser or chooser? (guesser, chooser): "
	game_type = gets.chomp
	if game_type == "guesser"
		player_game = Player.new(12)
	elsif game_type == "chooser"
		player_game = Computer.new(12)
	end
	player_game.play
end

choose_game
