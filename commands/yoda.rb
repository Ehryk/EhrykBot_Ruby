require 'open-uri'
require 'nokogiri'

class Yoda < Rubot::Core::Command
  def execute(server, message, options)
  
	insult = Nokogiri::HTML(open('http://www.insultme.net').read).xpath("//div[@class='text']//text()").to_s
	
	if ["them", "they"].include? message.body.downcase
		reply = ""
	elsif  message.body[message.body.length-1].match('s')
		reply = ""
	elsif ['a', 'e', 'i', 'o', 'u'].include? insult[0]
		reply = "An "
	else
		reply = "A "
	end
	
	reply += insult
	
	if ["me", "you"].include? message.body.downcase
		reply += ", you are."
	elsif  ["them", "they", "and"].any? {|x| message.body.downcaseinclude? x}
		reply += "s, they are."
	elsif  message.body.split.any? {|x| x =~ /[^s]s\z/i}
		reply = reply + "s, they are."
	else
		reply += ", " + message.body.downcase + " is."
	end
	
    server.msg(message.destination, reply.capitalize)
  end
end