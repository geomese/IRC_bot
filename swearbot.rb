#boring swearbot that reprimands a user for swearing


require "socket"

server = "chat.freenode.net"
port = "6667"
nick = "SwearBot"
channel = "#bojangles"
prefix = "privmsg #{channel} :"
is_curse = ["fuck", "shit", "ass", "hell", "damn"]

irc_server = TCPSocket.open(server, port)


irc_server.puts "USER bswearbot 0 * BSwearBot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} : Moppin up the dirt!"


until irc_server.eof? do
  msg = irc_server.gets.downcase
  #sender = irc_server.gets
  puts msg

#administering a reprimand

  swear = false
  is_curse.each do |s|
    swear = true if msg.include?(s)
  end

  if msg.include?(prefix) && swear
  
    reprimand = "Keep it clean!"
    irc_server.puts "PRIVMSG #{channel} :#{reprimand}"
  end

end