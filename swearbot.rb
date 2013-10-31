#boring swearbot that reprimands a user for swearing

#need to fix help command



require "socket"

server = "chat.freenode.net"
port = "6667"
nick = "SwearBot"
channel = "#bojangles"
prefix = "privmsg #{channel} :"
is_curse = ["fuck", "shit", "ass", "hell", "damn"]
dat_uptime = "uptime"
current_time = "whattime"

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


  if msg.include?(dat_uptime)
    startup = Time.new
    runtime = "I've been running since #{startup.strftime("%I:%M%p %d %B %Y")} for a total of #{(Time.now - startup)/60/60/24} days."
    irc_server.puts "PRIVMSG #{channel} :#{runtime}"
  elsif msg.include?(current_time)
    thetime = "It is currently #{Time.now.strftime("%I:%M%p %d %B %Y")}"
    irc_server.puts "PRIVMSG #{channel} :#{thetime}"
  #elsif msg.include?(bot_do) && (plzhelp)
  #  helpme = "Type \!swear uptime for current runtime of bot, \!swear time for current time."
  #  irc_server.puts "PRIVMSG #{channel} :#{helpme}"
  end

end