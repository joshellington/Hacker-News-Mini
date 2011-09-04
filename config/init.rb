require 'net/http'
require 'pp'
require 'uri'
require 'cobravsmongoose'
require 'json'
require 'digest/md5'
require 'ruby-hackernews'
require 'memcached'

require './lib/cache'

enable :sessions

require './config/'+ENV['RACK_ENV']

#
# Memcached
$cache = Memcached.new("localhost:11211")

#
# Mongo connection
# MongoMapper.connection = Mongo::Connection.new('10.179.98.224',27047, :pool_size => 5, :timeout => 5)
# MongoMapper.database = ''
# MongoMapper.database.authenticate('','')

#
# Helper functions

def base_uri
  base_uri_raw = request.env["HTTP_HOST"]+request.env["SCRIPT_NAME"]
  path = URI.parse(request.env["REQUEST_URI"]).path
  base_uri = "http://"+base_uri_raw.split(path)[0]
end

def curr_path
  base_uri_raw = request.env["HTTP_REFERER"]
end

def match(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

def relative_time(start_time)
  time = Time.now - start_time
end