class Computer

	attr_accessor :board, :turns
	def initialize(number_turns)
		@turns = number_turns
		@solution_count = {}
		# @solution = [ rand(7).to_s , rand(7).to_s , rand(7).to_s , rand(7).to_s ]
	end
		
	def board_setup
		@board = {}
		j = 1
		while j <= 12
			@board[j] = {"guess" => ["-", "-", "-", "-"], "feedback" => ["-", "-", "-", "-"]}
			j += 1
		end
	end

	def solution_input
		puts "Select your solution for the Computer to guess"
		puts "(four digits seperated by spaces using the numbers 1-6)"
		user_solution = gets.chomp
		user_solution = user_solution.split(' ')
		@solution = user_solution
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
#computer guess
	def guess(current_turn)
		puts "Press enter to continue"
		gets.chomp
		if current_turn < 7 
			computer_guess = [ current_turn.to_s, current_turn.to_s, current_turn.to_s, current_turn.to_s,]
		elsif current_turn == 7
			solution_comp
			computer_guess = @solution_numbers
		elsif current_turn > 6
			computer_guess = @solution_numbers.shuffle
		end
		@board[current_turn]["guess"] = computer_guess
	end
	#counts number of instances of each number
	def feedback_guess(current_turn)
		if current_turn < 7
		count = 0
			@board[current_turn]["feedback"].each do |el|
				if el == "b"
					count += 1
				end
			end
			@solution_count[current_turn] = count 
		end
	end

	def solution_comp
		solution_numbers = ""
		@solution_count.each do |key, value|
			solution_numbers += key.to_s * value
		end
		solution_numbers_a = solution_numbers.split('')
		@solution_numbers = solution_numbers_a
	end

	def previous_guess?
		@board.any? do |key, value|
			
		end

	end



	def play
		board_setup
		solution_input
		display_board
		current_turn = 1
		guess(current_turn)
		feedback(current_turn)
		
		while current_turn < 12 && @solution != @board[current_turn]["guess"] #!winner(current_turn)
			current_turn += 1
			display_board
			guess(current_turn)
			feedback(current_turn)
		end
		display_board
		game_end(current_turn)
	end

	def feedback(current_turn)
		# Tests for matching numbers and index, returns "b"
		solution_arr = @solution.dup  # SOLSOL this change fixed it
		@board[current_turn]["guess"].each_with_index do |el, idx|
			spot_open = feedback_el(current_turn)
			if @solution[idx] == el && #spot_open != false
				@board[current_turn]["feedback"][spot_open] = "b"
				solution_arr.delete_at(solution_arr.index(el))
			end
		end

		# tests for if the the number is in the solution, returns "w"
		@board[current_turn]["guess"].each_with_index do |el, idx|
			spot_open = feedback_el(current_turn)
				if solution_arr.include?(el)  && #spot_open != false #&& @solution[idx] != el
					@board[current_turn]["feedback"][spot_open] = "w"
					solution_arr.delete_at(solution_arr.index(el))
				end
			end

			feedback_guess(current_turn)
	end

	def feedback_el(current_turn)
		@board[current_turn]["feedback"].each_with_index do |el, idx|
			if el == "-"
				return idx
			end
		end
		false
	end

	def game_end(current_turn)
		if @board[current_turn]["guess"] == @solution
			puts "Congratulations!!! You stopped the nuclear detonation!!"
		else
			puts "The bomb exploded!!!!"
			puts "You Lose!"
		end
	end
end