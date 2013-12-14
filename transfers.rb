require 'selenium-webdriver'
require 'json'
require 'headless'
class BiceBank
	def movements
		headless = Headless.new
		headless.start
		driver = Selenium::WebDriver.for :chrome
		#driver = Selenium::WebDriver.for(:remote, :url => "http://127.0.0.1:8080")
		driver.manage.timeouts.implicit_wait = 10

		driver.get "http://www.bice.cl"
		rut = driver.find_element :css, "input[name=USUARIO-SHOW]"
		rut.send_keys ENV['BANK_USR']
		password = driver.find_element :css, "input[name=CTR]"
		password.send_keys ENV['BANK_PW']
		submit = driver.execute_script "window.stop"
		submit = driver.execute_script "try {onClickPersona()} catch(error){}"
	
	
		#link = driver.find_element :css, "[name=LFR2100] table a"
		#link.click

		menu = driver.find_elements :css, '#LBarCuentas_MNleft a'
		menu[1].click

		menu = driver.find_elements :css, '#LMenuCuentas_MNleft table tr table tr'
		link = menu[2].find_element :css, "a"
		link.click

		tables = driver.find_elements :css, '[name=contenido] table'
		relevant = tables[4]
		elements = relevant.find_elements :css, "tr"
		moves = []
		elements.drop(2).each do |row|
			cells = row.find_elements :css, 'td'
			move = {
				date: cells[0].text,
				doc: cells[1].text,
				desc: cells[2].text,
				decrease: cells[3].text,
				increase: cells[4].text,
				current: cells[5].text,
			}
			moves.push(move)
		end
		driver.close
		headless.destroy
		return moves
	end
end