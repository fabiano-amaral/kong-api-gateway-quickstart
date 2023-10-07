# init-kong.sh`

## Visão Geral

o `init-kong.sh`,é um script shell criado para inicializar o seu Kong API Gateway com configurações personalizadas para plugins e serviços no ambiente do nosso projeto. Este script importa automaticamente arquivos de configuração YAML para plugins e serviços no seu banco de dados Kong.

## Detalhamento do Script

Aqui está uma explicação linha a linha do que está acontecendo em `init-kong.sh`:

### Para Plugins

```bash
# Para plugins
for file in /etc/kong/config/plugins/*.yaml; do
  kong config db_import $file
done
```

Este loop percorre todos os arquivos `.yaml` do diretório local `./config/plugins/` e importa cada um para o banco de dados Kong usando o comando `kong config db_import`.

### Para Serviços

```bash
# Para services
for file in /etc/kong/config/services/*.yaml; do
  kong config db_import $file
done
```

De forma similar ao loop de plugins, este loop percorre todos os arquivos `.yaml` do diretório local `./config/services/` e os importa para o banco de dados Kong. Repare que local ou no container serão caminhos distintos, para entender olhe o Dockerfile

### Execução do Comando Original de Inicialização do Kong

```bash
# Executar o comando original de inicialização do Kong
exec /docker-entrypoint.sh kong docker-start
```

Este comando executa o ponto de entrada padrão do Docker para o Kong, que inicia o Kong propriamente dito.

## Boas Práticas

- Certifique-se de que todos os seus arquivos de configuração `.yaml` estão corretos e testados antes de usar este script.

- Valide as configurações após a execução do script. Você pode fazer isso usando a Kong Admin API para verificar se as rotas, serviços e plugins foram configurados como esperado.
