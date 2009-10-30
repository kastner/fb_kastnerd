# Lo-fi client for the Facebook API. E.g.:
#
#   fb = FacebookClient.new(:api_key => 'api-key', :secret => 'secret')
#   fb.call 'users.getInfo', :session_key => 'session-key', :uids => 'user-id', :fields => 'birthday'
#
# by Scott Raymond <sco@scottraymond.net>
# Public Domain.
#
class FacebookClient
  def initialize(default_params={})
    params = {
      :rest_server => 'http://api.new.facebook.com/restserver.php',
      :format      => 'JSON',
      :v           => '1.0',
      :api_key     => '',
      :secret      => '',
    }
    @default_params = params.merge(default_params)
  end

  def call(method, params={})
    params = @default_params.merge(params)
    params[:method]  ||= 'facebook.' + method
    params[:call_id] ||= Time.now.to_f.to_s
    secret      = params.delete(:secret)
    rest_server = params.delete(:rest_server)

    raw_string = params.inject([]) { |args, pair| args << pair.join('=') }.sort.join
    params[:sig] = Digest::MD5.hexdigest(raw_string + secret)

    response = Net::HTTP.post_form(URI.parse(rest_server), params)
    begin
      JSON.parse(response.read_body)
    rescue JSON::ParserError
      # some FB API methods, like send notification, don't return valid JSON, but rather JSON tokens, like '"123123"'
      response.read_body
    end
  end
end