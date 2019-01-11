require "sinatra"
require "sinatra/flash"
require_relative "authentication.rb"
require_relative "problem.rb"

get "/" do
	session[:generator] = nil
	erb :index
end

post "/check" do
	session[:check] = (session[:generator].check(params[:answer]))
	if session[:check] == false
		session[:answer] = session[:generator].solution
	end
	if session[:generator].is_decimal_to_binary
		redirect "/dec_to_binary_test"
	elsif session[:generator].is_binary_to_decimal
		redirect "/binary_to_dec_test"
	elsif session[:generator].is_random_binary
		redirect "/random_binary_test"
	elsif session[:generator].is_decimal_to_hex
		redirect "/dec_to_hex_test"
	elsif session[:generator].is_hex_to_decimal
		redirect "/hex_to_dec_test"
	elsif session[:generator].is_random_hex
		redirect "/random_hex_test"
	else
		redirect "/"
	end
end

get "/dec_to_binary_test" do
	if session[:generator].nil? || session[:generator].type != 1
		session[:generator] = Random_Problem_Generator.new(1)
	end
	session[:generator].generate
	@problem = session[:generator]
	@instructions = "Convert this decimal number to a binary number"
	@previous = session[:check]
	@answer = session[:answer]

	session[:check] = nil
	session[:answer] = nil

	erb :test_display
end

get "/binary_to_dec_test" do
	if session[:generator].nil? || session[:generator].type != 2
		session[:generator] = Random_Problem_Generator.new(2)
	end
	session[:generator].generate
	@problem = session[:generator]
	@instructions = "Convert this binary number to a decimal number"
	@previous = session[:check]
	@answer = session[:answer]

	session[:check] = nil
	session[:answer] = nil

	erb :test_display
end

get "/random_binary_test" do
	if session[:generator].nil? || session[:generator].type != 3
		session[:generator] = Random_Problem_Generator.new(3)
	end
	choice = session[:generator].generate
	@problem = session[:generator]

	if choice == 0
		@instructions = "Convert this decimal number to a binary number"
	else
		@instructions = "Convert this binary number to a decimal number"
	end
	@previous = session[:check]
	@answer = session[:answer]

	session[:check] = nil
	session[:answer] = nil

	erb :test_display
end

get "/dec_to_hex_test" do
	if session[:generator].nil? || session[:generator].type != 4
		session[:generator] = Random_Problem_Generator.new(4)
	end
	session[:generator].generate
	@problem = session[:generator]
	@instructions = "Convert this decimal number to a hexadecimal number"
	@previous = session[:check]
	@answer = session[:answer]

	session[:check] = nil
	session[:answer] = nil

	erb :test_display
end

get "/hex_to_dec_test" do
	if session[:generator].nil? || session[:generator].type != 5
		session[:generator] = Random_Problem_Generator.new(5)
	end
	session[:generator].generate
	@problem = session[:generator]
	@instructions = "Convert this hexadecimal number to a decimal number"
	@previous = session[:check]
	@answer = session[:answer]

	session[:check] = nil
	session[:answer] = nil

	erb :test_display
end

get "/random_hex_test" do
	if session[:generator].nil? || session[:generator].type != 6
		session[:generator] = Random_Problem_Generator.new(6)
	end
	choice = session[:generator].generate
	@problem = session[:generator]

	if choice == 0
		@instructions = "Convert this decimal number to a hexadecimal number"
	else
		@instructions = "Convert this hexadecimal number to a decimal number"
	end
	@previous = session[:check]
	@answer = session[:answer]

	session[:check] = nil
	session[:answer] = nil

	erb :test_display
end