# Ansible Configuration Notes
Within this directory is a dockerfile to build an Ansible instant that is fully configured for automating windows configurations.

Each dictory is a set of playbooks for each type of system.


### Windows
Initial Requirements for Windows server

```powershell
winrm quickconfig -force
winrm set winrm/config/service/Auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Enable-PSRemoting -Force
```

### Podman
Podman commands for building container

```bash
podman build -t my-ansible-img:latest -f ./Dockerfile .
```

Commands for running container with bash access

```bash
podman run -it --name my-ansible my-ansible-img:latest /bin/bash
```

### Ansible
Testing connections

```bash
ansible windows -i inv.ini -m win_ping
```

Testing DC playbook

```bash
ansible-playbook -i inv.ini WinDC_site.yml
```

