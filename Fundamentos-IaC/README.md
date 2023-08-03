

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