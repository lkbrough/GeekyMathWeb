require 'data_mapper'

class Problem
	attr_reader :number, :solution, :type, :instructions

	def initialize(problem_num, type)
		@type = type
		create(problem_num)
	end

	def create(problem_num)
		problem_num = problem_num.to_int
		if is_decimal_to_binary
			@number = problem_num.to_s
			@solution = problem_num.to_s(2)
			@instructions = "Convert this decimal number to a binary number"
		elsif is_binary_to_decimal
			@number = problem_num.to_s(2)
			@solution = problem_num.to_s
			@instructions = "Convert this binary number to a decimal number"
		elsif is_random_binary
			choice = rand(2)
			if choice == 0
				@number = problem_num.to_s
				@solution = problem_num.to_s(2)
				@instructions = "Convert this decimal number to a binary number"
			else
				@number = problem_num.to_s(2)
				@solution = problem_num.to_s
				@instructions = "Convert this binary number to a decimal number"
			end
			return choice
		elsif is_decimal_to_hex
			@number = problem_num.to_s
			@solution = problem_num.to_s(16)
			@instructions = "Convert this decimal number to a hexadecimal number"
		elsif is_hex_to_decimal
			@number = problem_num.to_s(16)
			@solution = problem_num.to_s
			@instructions = "Convert this hexadecimal number to a decimal number"
		elsif is_random_hex
			choice = rand(2)
			if choice == 0
				@number = problem_num.to_s
				@solution = problem_num.to_s(16)
				@instructions = "Convert this decimal number to a hexadecimal number"
			else
				@number = problem_num.to_s(16)
				@solution = problem_num.to_s
				@instructions = "Convert this hexadecimal number to a decimal number"
			end
			return choice
		else
			@number = problem_num.to_s
			@solution = problem_num.to_s(10)
			@instructions = "Please go to a different page, an error has happened"
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
	attr_reader :problem
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

class Problem_Set
	include DataMapper::Resource
	property :id, Serial
	property :owner, Integer
	property :problem_count, Integer
	property :problems_string, String
	property :type_string, String

	def add_problem(number, type)
		:problems_string << " " << number.to_s
		:type_string << " " << type.to_s
		:problem_count += 1
	end

	def get_problem(cnt)
		problems = self.problem_string.split(' ')
		types = self.type_string.split(' ')

		if cnt >= problems.length
			return nil
		end

		problem = Problem(problems[cnt], types[cnt])
		return problem
	end

	def is_problem_set
		return true
	end
end