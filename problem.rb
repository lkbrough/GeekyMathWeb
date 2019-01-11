class Problem
	attr_reader :number, :solution, :type

	def initialize(problem_num, type)
		@type = type
		create(problem_num)
	end

	def create(problem_num)
		problem_num = problem_num.to_int
		if is_decimal_to_binary
			@number = problem_num.to_s
			@solution = problem_num.to_s(2)
		elsif is_binary_to_decimal
			@number = problem_num.to_s(2)
			@solution = problem_num.to_s
		elsif is_random_binary
			choice = rand(2)
			if choice == 0
				@number = problem_num.to_s
				@solution = problem_num.to_s(2)
			else
				@number = problem_num.to_s(2)
				@solution = problem_num.to_s
			end
			return choice
		elsif is_decimal_to_hex
			@number = problem_num.to_s
			@solution = problem_num.to_s(16)
		elsif is_hex_to_decimal
			@number = problem_num.to_s(16)
			@solution = problem_num.to_s
		elsif is_random_hex
			choice = rand(2)
			if choice == 0
				@number = problem_num.to_s
				@solution = problem_num.to_s(16)
			else
				@number = problem_num.to_s(16)
				@solution = problem_num.to_s
			end
			return choice
		else
			@number = problem_num.to_s
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

class Random_Problem_Generator < Problem
	def initialize(type)
		@problem = 0
		number = rand(((@problem / 5) + 1) * 4)
		super(number, type)
	end

	def generate
		number = rand(((@problem / 5) + 1) * 4)
		@problem += 1
		create(number)
	end

	def check(ans)
		if super(ans)
			@problem += 1
		else
			@problem = 0
		end
		return super(ans)
	end
end