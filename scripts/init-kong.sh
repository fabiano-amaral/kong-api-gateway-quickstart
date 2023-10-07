#!/bin/sh

# Para plugins
for file in /etc/kong/config/plugins/*.yaml; do
  kong config db_import $file
done

# Para services
for file in /etc/kong/config/services/*.yaml; do
  kong config db_import $file
done

# Executar o comando original de inicialização do Kong
exec /docker-entrypoint.sh kong docker-start
