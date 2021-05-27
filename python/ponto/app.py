import time
from selenium.webdriver import Chrome
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import pause
from datetime import datetime
import getpass #lib que tras o hide password input
import ctypes #lib que tras os comandos do windows

url = 'https://ponto.paschoalotto.com.br'

passwd = getpass.getpass()
#pause.until(datetime(2020, 12, 7, 18, 1)) #Comando para realizar tarefa agendada
browser = Chrome()
browser.get(url)
time.sleep(5)
browser.find_element_by_id('username').send_keys('41972394835')
browser.find_element_by_id ('password').send_keys(passwd)
browser.find_element_by_id('btnLogin').click()
time.sleep(5)
browser.find_element_by_id('formMarc:j_idt59').click()
time.sleep(5)
browser.quit()
#time.sleep(2)
#ctypes.windll.user32.LockWorkStation() #comando para bloquear a tela do computador
