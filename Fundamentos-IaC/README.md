

## Iniciando o projeto manualmente

Executar os comando na VM

```shell
# ativar VM dentro da pasta tcc
cd tcc
. venv/bin/activate

# ver pacotes instalados
pip freeze

django-admin startproject setup .

python manage.py runserver 0.0.0.0:8000

# desativar vend
deactivate

# remover projeto django
rm -rf db.sqlite3 manage.py setup/
```

## Abrindo o projeto

Editar o arquivo `settings.py` dentro da pasta setup e adicionar em ALLOWED_HOSTS o valor `'*'``

```shell
vim settings.py

# ALLOWED_HOSTS = ['*']
```

## Ansible

Comando para executar o playbook

```shell

# gerar SSH
ssh-keygen -f iac-prd -t rsa

# dev
ansible-playbook env/dev/playbook.yml -u ubuntu --private-key env/dev/iac-dev -i infra/hosts.yml 

# prod
ansible-playbook env/prd/playbook.yml -u ubuntu --private-key env/prd/iac-prd -i infra/hosts.yml 
```