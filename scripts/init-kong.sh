#!/bin/sh

# Para plugins
# Verificar se há arquivos .yaml para evitar erro se o glob não encontrar nada
if ls /etc/kong/config/plugins/*.yaml 1> /dev/null 2>&1; then
  for file in /etc/kong/config/plugins/*.yaml; do
    echo "Importing plugin config: $file"
    kong config db_import "$file"
  done
fi

# Para services
# Verificar se há arquivos .yaml
if ls /etc/kong/config/services/*.yaml 1> /dev/null 2>&1; then
  for file in /etc/kong/config/services/*.yaml; do
    echo "Importing service config: $file"
    kong config db_import "$file"
  done
fi

# Executar o comando Kong passado como argumento, ou o padrão.
# O /docker-entrypoint.sh é o entrypoint original da imagem Kong.
echo "Executing Kong command with /docker-entrypoint.sh: $@"
if [ $# -eq 0 ]; then
  exec /docker-entrypoint.sh kong docker-start
else
  exec /docker-entrypoint.sh "$@"
fi
