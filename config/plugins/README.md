# Configuração de Plugins para Kong

## Visão Geral

Esta pasta, `./config/plugins`, é destinada exclusivamente para armazenar as configurações de plugins que você deseja aplicar aos serviços e rotas em seu ambiente Kong. Note que os plugins especificados aqui são para ativação e configuração, e não para instalação. Para instalar novos plugins, você deve adicionar as especificações no arquivo `plugins.yaml` localizado na raiz do projeto.

## Estrutura do Diretório

Cada arquivo YAML nesta pasta representa a configuração de um plugin específico. O nome do arquivo geralmente deve corresponder ao nome do plugin para fácil identificação. Por exemplo, para o plugin de "rate-limiting", você poderia ter um arquivo chamado `rate-limit.yaml`.

## Formato do Arquivo

Os arquivos YAML devem seguir o formato especificado pela Kong, que geralmente tem a seguinte aparência:

```yaml
_format_version: "3.0"
_transform: false

plugins:
- name: nome-do-plugin
  config:
    chave1: valor1
    chave2: valor2
```

## Como Utilizar

1. **Adicionar um Novo Plugin**: Para adicionar um novo plugin, crie um novo arquivo YAML nesta pasta e adicione a configuração apropriada.

2. **Modificar um Plugin Existente**: Para alterar as configurações de um plugin já existente, simplesmente edite o arquivo YAML correspondente.

3. **Remover um Plugin**: Se você deseja desativar um plugin, você pode simplesmente remover o arquivo YAML correspondente ou comentar o conteúdo.

## Boas Práticas

- **Nomeação de Arquivos**: Mantenha os nomes dos arquivos consistentes com os nomes dos plugins para facilitar a manutenção.

- **Documentação**: Adicione comentários aos arquivos YAML para explicar configurações não triviais.

- **Controle de Versão**: Mantenha esses arquivos sob controle de versão para rastrear as mudanças feitas ao longo do tempo.

- **Teste**: Sempre teste as configurações em um ambiente separado antes de aplicá-las ao ambiente de produção.

## Dicas de Depuração

Caso encontre problemas:

- Verifique se o nome do plugin no arquivo YAML coincide com o nome do plugin como é conhecido pelo Kong.

- Certifique-se de que o plugin que você está tentando configurar já foi instalado. A instalação é feita através do arquivo `plugins.yaml` na raiz.

- Consulte os logs do Kong para obter mensagens de erro que podem ajudar na depuração.
