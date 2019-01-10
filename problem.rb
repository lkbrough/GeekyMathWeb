class Problem
	def initialize(problem_num, type)
		@type = type
		if is_decimal_to_binary
			@number = problem_num
			@solution = problem_num.to_s(2)
		elsif is_binary_to_decimal
			@number = problem_num.to_s(2)
			@solution = problem_num
		elsif is_random_binary
			choice = rand(2)
			if choice == 0
				@number = problem_num
				@solution = problem_num.to_s(2)
			else
				@number = problem_num.to_s(2)
				@solution = problem_num
			end
		elsif is_decimal_to_hex
			@number = problem_num
			@solution = problem_num.to_s(16)
		elsif is_hex_to_decimal
			@number = problem_num.to_s(16)
			@solution = problem_num
		elsif is_random_hex
			choice = rand(2)
			if choice == 0
				@number = problem_num
				@solution = problem_num.to_s(16)
			else
				@number = problem_num.to_s(16)
				@solution = problem_num
			end
		else
			@number = problem_num
			@solution = problem_num.to_s(10)
		end
	end

	def check(ans)
		return @solution == ans
	end

	def is_decimal_to_binary
		return @type == 1
	end

	def is_binary_to_decimal
		return @type == 2
	end

	def is_random_binary
		return @type == 3
	end

	def is_decimal_to_hex
		return @type == 4
	end

	def is_hex_to_decimal
		return @type == 5
	end

	def is_random_hex
		return @type == 6
	end
end

class RandomProblemGenerator < Problem
	def initialize(type)
		@problem = 0
		number = rand((@problem / 5) * 4)
		super(number, type)
	end

	def generate
		number = rand((@problem / 5) * 4)
		@problem += 1
		super(number, @type)
	end

	def check(ans)
		if super.check(ans)
			@problem += 1
			return true
		else
			@problem = 0
			return false
		end
	end
end