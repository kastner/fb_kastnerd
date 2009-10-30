$:.unshift File.dirname(__FILE__) + '/lib/mustache/lib'
require 'sinatra/base'
require 'mustache/sinatra'
require 'ruby-debug'
require 'kastnerd'
require 'lib/fb_client'
load 'api'

use Rack::ShowExceptions

run Kastnerd.new
