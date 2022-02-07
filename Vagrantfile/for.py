import paramiko

client = paramiko.SSHClient()

client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

user = 'vagrant'

linuxMachines = ["192.168.0.200", "192.168.0.210", "192.168.0.220"]

for i in linuxMachines:
    client.load_system_host_keys()
    client.connect(i, 22, user)
    stdin, stdout, stderr = client.exec_command('hostname')
    print(stdout.read().decode())