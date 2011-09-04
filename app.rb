require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './config/init'

#
# Before any route is run
before do
  @path = request.env['SCRIPT_NAME']
end

#
# Routes
match '/' do
  @entries = Entry.all
  @next_page = 2

  erb :home
end

match '/page/:page/?' do
  page = params[:page].to_i
  @entries = Entry.all(page).to_a.reverse.shift(30)
  @entries.reverse!

  @next_page = page + 1
  @prev_page = page - 1

  erb :home
end

match '/api/:url/?' do
  content_type :json
  Cache.get(params[:url], params)
end