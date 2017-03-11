require 'sinatra'
<<<<<<< HEAD
require "slack"
require "yaml"
require 'dotenv/load'
require 'pry'
require 'sinatra/static_assets'

helpers do

  def get_messages

    token = ENV['TOKEN_2'] || (print "Token: "; gets.strip)
    client = Slack::Client.new token: token

    messages = client.pins_list(channel: ENV['GENERAL'])
    messages['items'].each do |msg|
      msg_hash = {}
      if msg['type'] == 'message'
        msg_hash[:user_id] = msg['message']['user']
        msg_hash[:message] = msg['message']['text']
      end
      @@messages << msg_hash
    end
    users = Hash[client.users_list["members"].map{|m| [m["id"], m["name"]]}]
    photo = Hash[client.users_list["members"].map{|m| [m["id"], m["profile"]["image_original"]]}]

    @@messages.each do |person|
      person[:username] = users[person[:user_id]]
      person[:photo] = photo[person[:user_id]]
    end

    @@messages.each do |person|
      person[:username] = users[person[:user_id]]
    end
  end

end


get '/' do
  @@messages = []
  get_messages
  erb :index
end

get '/clock' do
  erb :clock
end

