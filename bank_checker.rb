# encoding: utf-8
require 'digest/sha1'
require './transfers.rb'
require 'erb'
require('aws/ses')
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

class BankChecker

  def initialize
    @ses = AWS::SES::Base.new(
      :access_key_id     => ENV['ACCESS_KEY'], 
      :secret_access_key => ENV['SECRET_KEY']
    )
  end 

  def checkit
    begin 
    file = File.new("current.hash", "r")
    line = file.gets
    file.close
    rescue => err
    	puts err
    end
    bank = BiceBank.new
    movements = bank.movements
    current = Digest::SHA1.hexdigest JSON.generate(movements)
    if line != current then
    	puts "it changed!"
    	#send email with movements
      template = %{
        <%# encoding: utf-8 %>
      <html>
        <head></head>
        <body>
        <table>
        <tr>
        <th>Date</th> <th>Doc</th> <th>Desc</th> 
        <th>Decrease</th> <th>Increase</th> <th>Current</th>
        </tr>
        <% movements.each do |m|%>
        <tr>
        <td><%=m[:date]%></td> <td><%=m[:doc]%></td> <td><%=m[:desc]%></td> 
        <td><%=m[:decrease]%></td> <td><%=m[:increase]%></td> <td><%=m[:current]%></td>
        </tr>
        <%end%>
        </table>
        </body>
        </html>
      }
      rhtml = ERB.new(template)
      body = rhtml.result(binding)
      time = Time.new
      #current = time.strftime("%Y-%m-%d %H:%M:%S")
      @ses.send_email ({
                 :to =>         ENV['DESTINATARY'],
                 :source =>     '"BankCheck" <bank@patagoniabitcoin.com>',
                 :subject =>    "Cambio en tu cuenta - #{current}",
                 :html_body =>  body
      	})
    	File.open('current.hash', 'w') { |file| file.write(current) }
    end
  end
end