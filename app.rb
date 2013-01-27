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
  @entries = Entry.all(1)
  # ap @entries.inspect
  @next_page = 2

  @title = 'Home'

  erb :home
end

match '/page/:page/?' do
  page = params[:page].to_i
  if page == 1
    redirect '/'
  end
  @entries = Entry.all(page).to_a.reverse.shift(30)
  @entries.reverse!

  @title = 'Page '+page.to_s

  @next_page = page + 1
  @prev_page = page - 1

  erb :home
end

match '/ask/?' do
  @entries = Entry.questions
  @title = 'Ask'

  erb :home
end

match '/new/?' do
  @entries = Entry.newest
  @title = 'New'

  erb :home
end

match '/api/:url/?' do
  content_type :json
  Cache.get(params[:url], params)
end