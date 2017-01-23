require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "json"
require "rest-client"
require "uri"
# set :bind, '0.0.0.0'

require_relative "cookbook"
require_relative "recipe"
require_relative "scrapper"



configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

helpers do
  def img(url)
    "<img src='#{url}' style='width:100%'>"
  end
end

# before do
#     content_type 'application/json'
# end

get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  @recipes = @cookbook.all
  erb :index
end

post '/new' do
  @recipe = Recipe.new(params)
  @cookbook = Cookbook.new('recipes.csv')
  @cookbook.add_recipe(@recipe)
  redirect '/'
end

get '/new' do
  erb :new
end

post '/import' do
  @jamie = JamieOliver.new(params[:keywords])
  @search_results = @jamie.search
   erb :results
end

get '/import' do
  erb :import
end

get '/add' do
  @recipe = Recipe.new(params)
  @cookbook = Cookbook.new('recipes.csv')
  @cookbook.add_recipe(@recipe)
  redirect '/'
end

get '/delete' do
  @cookbook = Cookbook.new('recipes.csv')
  @recipes = @cookbook.all
  erb :delete
end

get '/delete/recipe' do
  @cookbook = Cookbook.new('recipes.csv')
  @cookbook.remove_recipe(params[:img_url])
  redirect '/'
end
