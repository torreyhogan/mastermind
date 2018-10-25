class Game
end

class Board

	attr_accessor :board, :winning_move

	def initialize
		@winning_move = random_color
		@board = Hash.new
	end

	def random_color
		color = { 1 => "blue", 2 => "green", 3 => "orange", 
							4 => "purple", 5 => "red", 6 => "yellow"}
		random_solution = [ color[rand(7)] , color[rand(7)] , color[rand(7)] , color[rand(7)] ]
		return random_solution
	end

	def solution

	end

	def
	 color_to_number
	end


	def win?
	end

	def feedback
	end
end

new_board = Board.new
puts new_board.winning_move


# show player board
# ask player for guess
# check for win
# return board with feedback 