require "sinatra"
require "sinatra/flash"
require_relative "authentication.rb"

get "/" do
	erb :index
end