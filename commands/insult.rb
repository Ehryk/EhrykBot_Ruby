require 'open-uri'
require 'nokogiri'

class Insult < Rubot::Core::Command
  def execute(server, message, options)
	if ["them"].include? message.body.downcase
		reply = ""
	elsif ["me"].include? message.body.downcase
		reply = "You"
	else
		reply = message.body
	end
		
	if ["they"].include? message.body.downcase || message.body[message.body.length-1].match('s')
		reply = reply + " are "
	elsif ["you", "me"].include? message.body.downcase
		reply = reply + " are a "
	elsif ["them"].include? message.body.downcase
		reply = reply + "They are "
	else
		reply = reply + " is a "
	end
	
	reply = reply + Nokogiri::HTML(open('http://www.insultme.net').read).xpath("//div[@class='text']//text()").to_s
	
	if ["them", "they"].include? message.body.downcase
		reply = reply + "s"
	elsif  message.body[message.body.length-1].match('s')
		reply = reply + "s"
	end
	
    server.msg(message.destination, reply)
  end
end