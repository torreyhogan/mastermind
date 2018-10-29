class Player

	attr_accessor :board, :turns
	def initialize(number_turns)
		@turns = number_turns
		@solution = [ (rand(6) + 1).to_s , (rand(6) + 1).to_s , (rand(6) + 1).to_s , (rand(6) + 1).to_s ]
	end
		
	def board_setup
		@board = {}
		j = 1
		while j <= 12
			@board[j] = {"guess" => ["-", "-", "-", "-"], "feedback" => ["-", "-", "-", "-"]}
			j += 1
		end
	end

	def display_board
		@board.each do |guess_number, value|
			string = "- #{}"#{guess_number} --> "
			value["guess"].each { |item|
				string += "#{item} "
			}
			string += "-->"
			value["feedback"].each { |item|
				string += "#{item} "
			}
			puts string

		end
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
		print @solution
		while current_turn < 12 && @solution != @board[current_turn]["guess"] #!winner(current_turn)
			current_turn += 1
			display_board
			guess(current_turn)
			feedback(current_turn)
		end
		game_end(current_turn)
	end



	def feedback(current_turn)
		# Tests for matching numbers and index, returns "b"
		solution_arr = @solution.dup  # SOLSOL this change fixed it
		@board[current_turn]["guess"].each_with_index do |el, idx|
			spot_open = feedback_el(current_turn)
			if @solution[idx] == el && spot_open != false
				@board[current_turn]["feedback"][spot_open] = "b"
				solution_arr.delete_at(solution_arr.index(el))
			end

		end

		# tests for if the the number is in the solution, returns "w"
		@board[current_turn]["guess"].each_with_index do |el, idx|
			spot_open = feedback_el(current_turn)
				if solution_arr.include?(el) && @solution[idx] != el && spot_open != false 
					@board[current_turn]["feedback"][spot_open] = "w"
					solution_arr.delete_at(solution_arr.index(el))
				end
			end

	end

	def feedback_el(current_turn)
		@board[current_turn]["feedback"].each_with_index do |el, idx|
			if el == "-"
				return idx
			end
		end
		false
	end

	def game_end(current_turn_temp)
		if @board[current_turn_temp]["guess"] == @solution
			puts "Congratulations!!! You stopped the nuclear detonation!!"
		else
			puts "The bomb exploded!!!!"
			puts "You Lose!"
		end
	end
end