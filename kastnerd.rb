class Kastnerd < Sinatra::Base
  register Mustache::Sinatra
  
  set :static, true
  set :public, File.join(File.dirname(File.expand_path(__FILE__)), "public")
  set :views, "templates/"
  set :mustaches, "views/"
  
  get "/" do
    mustache :index
  end
  
  get "/fb" do
    @wall_posts = fql(page_wall_posts_fql(166846993630))
    mustache :fb
  end
  
  get "/john-fb" do
    @wall_posts = fql(page_wall_posts_fql(140585057793))
    mustache :fb
  end
  
  def fql(fql)
    result = fb_client.call 'fql.query', :query => fql
    result.map {|p| p.inject({}) {|h, (k,v)| h[k.intern] = v; h}}
  end
  
  def page_wall_posts_fql(page_id)
    fields = %w|actor_id message|
    fql = "SELECT #{fields.join(", ")} FROM stream WHERE source_id = '#{page_id}'"
  end
  
  def fb_client
    FacebookClient.new(:api_key => API_KEY, :secret => SECRET_KEY)
  end
end