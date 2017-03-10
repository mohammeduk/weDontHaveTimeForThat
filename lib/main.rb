require "slack"
require "yaml"
require 'dotenv/load'
require 'pry'

class weDontHaveTimeForThat

  def get_messages

    token = ENV['TOKEN_2'] || (print "Token: "; gets.strip)
    client = Slack::Client.new token: token

    messages = client.pins_list(channel: ENV['GENERAL'])
    messages_list = []

    messages['items'].each do |msg|
      msg_hash = {}
      if msg['type'] == 'message'
        msg_hash[:user_id] = msg['message']['user']
        msg_hash[:message] = msg['message']['text']
      end
      messages_list << msg_hash
    end
    users = Hash[client.users_list["members"].map{|m| [m["id"], m["name"]]}]

    messages_list.each do |person|
      person[:username] = users[person[:user_id]]
      binding.pry

    end
  end
end
