require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

helpers do
  def img(name)
    "<img src='#{name}' style='width:100%'>"
  end
end

get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  @recipes = @cookbook.all
  erb :index
end

get '/add_recipe' do
  erb :add_recipe
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
