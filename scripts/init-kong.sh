#!/bin/sh

## skip for KONG_ROLE=data_plane

# Para plugins
if [ "$KONG_ROLE" != "data_plane" ]; then
  for file in /etc/kong/config/plugins/*.yaml; do
    kong config db_import $file
  done

  # Para services
  for file in /etc/kong/config/services/*.yaml; do
    kong config db_import $file
  done
fi

# Executar o comando original de inicialização do Kong
exec /docker-entrypoint.sh kong docker-start
