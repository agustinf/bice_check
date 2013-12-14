require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome
driver.manage.timeouts.implicit_wait = 10

driver.get "http://www.bice.cl"
rut = driver.find_element :css, "input[name=USUARIO-SHOW]"
rut.send_keys ENV['BANK_USR']
password = driver.find_element :css, "input[name=CTR]"
password.send_keys ENV['BANK_PW']
driver.execute_script "cert_registerHit=1"
submit = driver.execute_script "onClickPersona()"
driver.execute_script "BiCEsend('450')"
tabla = driver.find_element :css, "#BarCONSOLIDADO table table"
elements = tabla.find_elements :css, "td"
puts elements[5].text
