class Game
end

class Board

	attr_accessor :board, :solution, :turns

	def initialize(number_turns)
		@turns = number_turns
		@solution = [1.to_s, 2.to_s, 3.to_s ,4.to_s ]#[ rand(7).to_s , rand(7).to_s , rand(7).to_s , rand(7).to_s ]
	end

	# def random_color
	# 	color = { 1 => "blue", 2 => "green", 3 => "orange", 
	# 						4 => "purple", 5 => "red", 6 => "yellow"}
	# 	random_solution = [ color[rand(7)] , color[rand(7)] , color[rand(7)] , color[rand(7)] ]
	# 	return random_solution
	# end
		
	def board_setup
		@board = {}
		j = 1
		while j <= 12
			@board[j] = {"guess" => ["-", "-", "-", "-"], "feedback" => ["-", "-", "-", "-"]}
			j += 1
		end
	end

	def display_board
		@board.each { |guess_number, value|
			string = "- #{}"#{guess_number} --> "
			value["guess"].each { |item|
				string += "#{item} "
			}
			string += "-->"
			value["feedback"].each { |item|
				string += "#{item} "
			}
			puts string
		}
	end

	def guess(turn_number)
		puts "Please enter your guess: "
		user_guess = gets.chomp
		user_guess_a = user_guess.split(' ')
		@board[turn_number]["guess"] = user_guess_a
	end

	def play
		board_setup
		current_turn = 1
		display_board
		guess(current_turn)
		feedback(current_turn)
		while current_turn < 12 && @solution != @board[current_turn]["guess"] #!winner(current_turn)
			current_turn += 1
			display_board
			guess(current_turn)
			feedback(current_turn)
		end

		if @board[current_turn]["guess"] == @solution
			puts "Congratulations!!! You stopped the nuclear detonation!!"
		else
			puts "The bomb exploded!!!!"
			puts "You Lose!"
		end
	end

	def feedback(current_turn)
		@board[current_turn]["guess"].each_with_index { |el, idx|
			spot_open = feedback_el(current_turn)
			if @solution[idx] == el && spot_open != false
				@board[current_turn]["feedback"][spot_open] = "b"
			end
		}

		solution_arr = @solution
		current_arr = @board[current_turn]["guess"]
		@board[current_turn]["guess"].each_with_index { |el, idx|
			spot_open = feedback_el(current_turn)
				if solution_arr.include?(el) && @solution[idx] != @board[current_turn]["guess"][idx] && spot_open != false
					@board[current_turn]["feedback"][spot_open] = "w"
				end
			}

	end

	def feedback_el(current_turn)
		@board[current_turn]["feedback"].each_with_index { |el, idx|
			if el == "-"
				return idx
			end
		}
		false
	end
end

new_board = Board.new(12)

new_board.play




# show player board
# ask player for guess
# check for win
# return board with feedback 
