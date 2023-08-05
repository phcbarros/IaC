cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
tee -a playbook.yml > /dev/null <<EOT
- hosts: localhost
  tasks: 
  - name: Instalando o python3, virtualenv
    apt:
      pkg:
      - python3
      - virtualenv
      update_cache: yes
    become: yes

  - name: Git Clone
    ansible.builtin.git:
      repo: https://github.com/alura-cursos/clientes-leo-api.git
      dest: /home/ubuntu/tcc
      version: master
      force: yes

  - name: Instalando dependências com pip (Django e Django Rest)
    pip:
      virtualenv: /home/ubuntu/tcc/venv
      requirements: /home/ubuntu/tcc/requirements.txt

  - name: Alterando o hosts do settings
    lineinfile:
      path: /home/ubuntu/tcc/setup/settings.py
      regex: 'ALLOWED_HOSTS'
      line: 'ALLOWED_HOSTS = ["*"]'
      backrefs: yes

  - name: Configurando o banco de dados
    shell: '. /home/ubuntu/tcc/venv/bin/activate; cd /home/ubuntu/tcc; python manage.py migrate'

  - name: Carregando dados iniciais
    shell: '. /home/ubuntu/tcc/venv/bin/activate; cd /home/ubuntu/tcc; python manage.py loaddata clientes.json'

  - name: Iniciando servidor
    shell: '. /home/ubuntu/tcc/venv/bin/activate; cd /home/ubuntu/tcc; nohup python manage.py runserver 0.0.0.0:8000 &'
EOT
ansible-playbook playbook.yml