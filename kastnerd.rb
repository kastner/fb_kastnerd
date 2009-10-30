class Kastnerd < Sinatra::Base
  set :static, true
  set :public, File.join(File.dirname(File.expand_path(__FILE__)), "public")
end