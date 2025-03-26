# Operating Guide


To generate devuser key locally
```
ansible-playbook generate_ssh_key.yaml
```

to run backend server configs
```
ansible-playbook -i inventory/inventory.ini playbooks/site.yaml -u root --ask-pass  
```

to run server configs
```
ansible-playbook -i inventory.ini backend.yaml frontend.yaml
```

