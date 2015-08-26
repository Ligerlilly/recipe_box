require 'sinatra/activerecord'
require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require 'pry'
require './lib/tag'
require './lib/recipe'
require 'sinatra/partial'
# require 'sinatra/activerecord'
# require("bundler/setup")
# Bundler.require(:default)
#
# Dir[File.dirname(_FILE_) + '/lib/*.rb'].each { |file| require file}

get '/'  do
	erb(:index)
end

get '/recipes' do
	erb(:recipes)
end

post '/recipes' do
	@recipe = Recipe.create({ name: params['name'], ingredients: params['ingredients'], instructions: params['instructions'] })
	redirect "/recipes/#{@recipe.id}"
end

get '/recipes/:id' do
	@recipe = Recipe.find(params['id'].to_i)
	erb(:recipe)
end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params['id'].to_i)
	erb :recipe_form
end
