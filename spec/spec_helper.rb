ENV['RACK_ENV'] = 'test'
require 'sinatra/activerecord'
require 'rspec'
require 'pg'

require './lib/tag'
require './lib/recipe'



# ENV['RACK_ENV'] = 'test'
#
# # Dir[File.dirname(_FILE_) + '/../lib/*.rb'].each { |file| require file}
# require './lib/recipe'
# require './lib/tag'
# require 'bundler/setup'
# Bundler.require(:default, :test)
# set(:root, Dir.pwd)
#
require 'capybara/rspec'

require './app'

RSpec.configure do |config|
  config.after(:each) do
    Recipe.all.each do |task|
      task.destroy
    end
    Tag.all.each do |task|
      task.destroy
    end
  end
end
