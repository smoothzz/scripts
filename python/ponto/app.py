import time
from selenium.webdriver import Chrome
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import pause
from datetime import datetime
import getpass #lib que tras o hide password input
import ctypes #lib que tras os comandos do windows

<<<<<<< HEAD
url = 'SITE'
=======
url = 'site'
>>>>>>> e2aea72973032f4e4e64620746f81e0d38b40aca

passwd = getpass.getpass()
#pause.until(datetime(2020, 12, 7, 18, 1)) #Comando para realizar tarefa agendada
browser = Chrome()
browser.get(url)
time.sleep(5)
<<<<<<< HEAD
browser.find_element_by_id('username').send_keys('CPF')
=======
browser.find_element_by_id('username').send_keys('cpf')
>>>>>>> e2aea72973032f4e4e64620746f81e0d38b40aca
browser.find_element_by_id ('password').send_keys(passwd)
browser.find_element_by_id('btnLogin').click()
time.sleep(5)
browser.find_element_by_id('formMarc:j_idt59').click()
time.sleep(2)
browser.quit()
#time.sleep(2)
ctypes.windll.user32.LockWorkStation() #comando para bloquear a tela do computador
