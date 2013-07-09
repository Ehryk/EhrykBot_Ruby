require 'open-uri'
require 'nokogiri'

class Formal < Rubot::Core::Command
  def execute(server, message, options)
	
	reply = Nokogiri::HTML(open('http://www.pangloss.com/seidel/Shaker/index.html?').read).xpath("//font//text()").to_s
	
    server.msg(message.destination, reply)
  end
end