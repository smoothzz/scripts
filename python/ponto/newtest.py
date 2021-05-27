
from selenium.webdriver import Chrome
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import getpass #lib que tras o hide password input

passwd = getpass.getpass()
browser = webdriver.Chrome('./chromedriver')
browser.get("https://ponto.paschoalotto.com.br")
time.sleep(5)
browser.find_element_by_id('username').send_keys('41972394835')
browser.find_element_by_id ('password').send_keys(passwd)
browser.find_element_by_id('btnLogin').click()
time.sleep(5)
browser.find_element_by_id('formMarc:j_idt59').click()
time.sleep(5)
browser.quit()
