require_relative 'CashMachine'
require "socket"
require 'rack'

server = TCPServer.new('0.0.0.0', 3000)
class App
  def call(env)
    req = Rack::Request.new(env)
    params = env["QUERY_PARAMS"]

    atm = CashMachine.new
    case req.path
    when "/CashMachine"
      [200, { "Content-Type" => "text/html" }, ["CashMachine"]]
    when "/withdraw"
      if params.nil? || params["value"].nil?
        [402, { "Content-Type" => "text/html" }, ["Enter withdraw value:"]]

      elsif atm.withdraw(params["value"]) == 0
        [200, { "Content-Type" => "text/html" }, ["You have withdrawn #{params["value"]}$."]]

      else
        [403, { "Content-Type" => "text/html" }, ["This value is bigget than your balance!"]]

      end

    when "/deposit"
      if params.nil? || params["value"].nil?
        [401, { "Content-Type" => "text/html" }, ["Enter deposit value:"]]

      elsif atm.deposit(params["value"]) == 0
        [200, { "Content-Type" => "text/html" }, ["Your deposited #{params["value"]}."]]

      else
        [403, { "Content-Type" => "text/html" }, ["Invalid value, must be higher than zero!"]]

      end

    when "/balance"
      [200, { "Content-Type" => "text/html" }, ["Your balance is #{atm.balance}$."]]

    else
      [404, { "Content-Type" => "text/html" }, ["Not Found this page, try one of the proposed!"]]

    end
  end
end

def array_transform(array)
  result = {}
  array.each do |item|
    key = item.split("=")[0]
    value = item.split("=")[1]
    result[key] = value
  end
  result
end


app = App.new

while (connection = server.accept)
  request = connection.gets
  method, full_path, http_version = request.split(' ')
  path, params = full_path.split('?')
  status, headers, body = app.call(
    {
       'REQUEST_METHOD' => method,
       'PATH_INFO' => path,
       'QUERY_PARAMS' => params != nil ? array_transform(params.split('&')) : nil
    })

  connection.print "#{http_version} #{status} \r\n"
  headers.each do |key, value|
    connection.print("#{key}: #{value}\r\n")
  end

  connection.print "\r\n"

  body.each do |part|
    connection.print(part)
  end

  connection.close
end