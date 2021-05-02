require 'webrick'
require 'json'

#root = File.expand_path './public'
server = WEBrick::HTTPServer.new :Port => 4000, :DocumentRoot => './', :BindingAddress => '127.0.0.1'

class JunjiApiServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(req, res)
    file = File.read('./junji.json')
    data_hash = JSON.parse(file)
    json = data_hash.to_json
    res.body = json.force_encoding('UTF-8')
  end
end
  
server.mount("/", JunjiApiServlet)

trap("INT") {
    server.shutdown
}

server.start
