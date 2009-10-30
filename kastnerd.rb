class Kastnerd < Sinatra::Base
  register Mustache::Sinatra
  
  set :static, true
  set :public, File.join(File.dirname(File.expand_path(__FILE__)), "public")
  set :views, "templates/"
  set :mustaches, "views/"
  
  PAGE_ID = "166846993630"
  
  get "/" do
    mustache :index
  end
  
  get "/fb" do
    fields = %w|actor_id message|
    fql = "SELECT #{fields.join(", ")} FROM stream WHERE source_id = '#{PAGE_ID}'"
    posts = facebook_session.fql_query(fql, "XML")
    @wall_posts = posts.map {|p| p.inject({}) {|h, (k,v)| h[k.intern] = v; h}}
    mustache :fb
  end
  
  def facebook_session
    @facebook_session ||= begin
      if request.cookies[API_KEY]
        fb_session = Facebooker::Session.new(API_KEY, SECRET_KEY)
        secure_fields = %w|session_key user expires ss|.collect do |k| 
          request.cookies["#{API_KEY}_#{k}"]
        end
        fb_session.secure_with! *secure_fields
        fb_session
      end
    end
  end
  
  def facebook_user
    facebook_session.user
  end
end