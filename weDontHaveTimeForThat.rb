require 'json'
require 'sinatra'
require 'mongoid'
require 'pry'
require 'date'
require 'dotenv'
require 'oauth2'


Mongoid.load! "mongoid.yml"
Mongoid.raise_not_found_error = false
use Rack::Session::Cookie, :key => 'rack.session',
                          :domain => 'localhost',
                          :path => '/',
                          :expire_after => 2_592_000, # In seconds
                          :secret => 'put env file here'#puts a long random generated string

Dotenv.new

client_id = "152594237827.151958762560"
client_secret = "84062cd3619cd8e2a85645df5ebdc891"
client_url = 'http://localhost:4567'
client_redirect_url = 'http://localhost:4567/callback'
access_token = "xoxp-152594237827-152594238051-151988872929-71d134eeda8f30001a4e0e2dfd02c5f2"

client = OAuth2::Client.new(client_id, client_secret, :token_url => "/oauth/#{access_token}", :site =>'https://slack.com/api')

authorize_url = client.auth_code.authorize_url(:redirect_uri => client_redirect_url, :response_type => 'code')

token_request = client.auth_code.get_token(params[:code], :redirect_uri => client_redirect_url)
token_request.options[:header_format] = "OAuth %s"
token_string = token_request.token

request = OAuth2::AccessToken.new client, token_string, :header_format => "OAuth %s"
resp = request.get('/sites')
resp.body


get '/callback' do

end
