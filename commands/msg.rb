class Msg < Rubot::Core::Command
  acts_as_protected
  def execute(server, message, options)
  	channel = message.body.split(" ")[0]

  	if channel.include? "#"
  		reply = message.body.split(" ")[1..-1].join(" ")
  	else
  		channel = message.destination
  		reply = message.body
  	end

    server.msg(channel, reply)
  end
end