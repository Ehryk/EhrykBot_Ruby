require 'open-uri'
require 'nokogiri'

class Formal < Rubot::Core::Command
  def execute(server, message, options)

  	n = 1
	firstWord = message.body.split(/\s+/, n+1)[0...n].join(' ')
	if ["me"].include? message.body.downcase
		firstWord = message.from
	end

	reply = firstWord;
	reply += ": "
	
	reply += Nokogiri::HTML(open('http://www.pangloss.com/seidel/Shaker/index.html?').read).xpath("//font//text()").to_s
	reply = reply.gsub("\n", "")

	p("Reply = " + reply)

    server.msg(message.destination, reply)
  end
end