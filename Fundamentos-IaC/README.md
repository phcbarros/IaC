## Iniciando o projeto

Executar os comando na VM

```shell
django-admin startproject setup .

python manage.py runserver 0.0.0.0:8000
```

## Abrindo o projeto

Editar o arquivo `settings.py` dentro da pasta setup e adicionar em ALLOWED_HOSTS o valor `'*'``

```shell
vim settings.py

# ALLOWED_HOSTS = ['*']
```