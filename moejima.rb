# encoding: utf-8

require 'cinch'
require 'yaml'
require './plugins/timer.rb'

config = YAML.load(File.read('./config/config.yml.sample'))
puts config['channels'][0]
bot = Cinch::Bot.new do
  configure do |c|
    c.server = config['server']
    c.port = config['port']
    c.realname = config['realname']
    c.user = config['user']
    c.nick = config['nick']
    c.encoding = config['encoding']
    c.channels = config['channels']
    c.plugins.plugins = config['plugins'].map {|x| Object.const_get(x)}
  end

  on :message, "hello" do |m|
    m.reply "Hello, #{m.user.nick}"
  end
end

bot.start
