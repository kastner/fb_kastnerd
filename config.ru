$:.unshift File.dirname(__FILE__) + 'lib/mustache/lib'
require 'sinatra/base'
require 'mustache/sinatra'
require 'ruby-debug'
require 'kastnerd'

use Rack::Lint
use Rack::ShowExceptions
use Rack::Static, :urls => %w|/images /css|, :root => "public"
use Rack::Session::Cookie

run Kastnerd.new
