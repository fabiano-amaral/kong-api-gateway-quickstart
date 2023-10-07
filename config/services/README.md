# Configuração de Serviços no Kong API Gateway

## Visão Geral

A pasta `./config/services` (nesse projeto de exemplo) é onde a magia acontece para definir como o Kong gerencia os serviços que você quer expor. Cada arquivo YAML aqui corresponde a um serviço específico, com suas rotas associadas e outras configurações. Diferente dos plugins, cujas instruções estão na pasta `./config/plugins` e no arquivo `plugins.yaml`, este diretório é exclusivamente sobre a configuração de Services e Routes.

## Conceitos Básicos

### O que é um Service?

No universo do Kong, um "Service" é o ponto de destino final para suas requisições. Ele define onde e como as chamadas API são encaminhadas. Um Service contém configurações como a URL base, timeouts e número de tentativas em caso de falha.

### O que é uma Route?

Uma "Route" é como um mapa que orienta as requisições para o Service correspondente. Uma Route é sempre vinculada a um Service e ajuda a definir como as requisições para esse Service são tratadas. Isso inclui coisas como métodos HTTP aceitos, hosts permitidos e caminhos específicos.

### Diferenças Chave

Em resumo, o Service é o "para onde" e a Route é o "como". O Service especifica o destino, enquanto a Route esclarece como chegar lá.

## Arquitetura de Diretório

Cada arquivo YAML dentro deste diretório deve ser nomeado de forma que reflita o serviço que representa. Por exemplo, um serviço de autenticação pode ser definido em `authentication-service.yaml`.

## Formato do Arquivo e Exemplo Completo

Para ilustrar o que você pode fazer, aqui está um exemplo completo de um arquivo `services.yaml`.

```yaml
# Exemplo Completo de services.yaml
_format_version: "3.0"
_transform: false

# Seção para configurar o serviço
services:
  - name: exemplo-servico
    url: http://api.exemplo.com
    protocol: http
    host: api.exemplo.com
    port: 80
    path: /
    retries: 5
    connect_timeout: 60000
    write_timeout: 60000
    read_timeout: 60000

    # Seção para configurar as rotas
    routes:
      - name: exemplo-rota
        protocols:
          - http
          - https
        methods:
          - GET
          - POST
        hosts:
          - api.exemplo.com
        paths:
          - /exemplo
          - /exemplo2
```

### Detalhamento das Opções

No contexto de um Service:
- `protocol`, `host`, `port` e `path` definem o destino final.
- `retries`, `connect_timeout`, `write_timeout` e `read_timeout` são outros ajustes.

Para uma Route:
- `protocols`, `methods`, `hosts` e `paths` são responsáveis pelo roteamento.

## Guia de Uso Rápido

### Adicionando um Novo Serviço
1. Crie um novo arquivo YAML neste diretório.
2. Adicione as configurações necessárias.

### Editando ou Removendo um Serviço
- Para editar, basta alterar o arquivo YAML correspondente.
- Para remover, você pode excluir o arquivo ou comentar as linhas.

## Boas Práticas e Dicas de Depuração

- Mantenha a nomenclatura dos arquivos consistente.
- Comente seu YAML para melhor clareza.
- Sempre teste em um ambiente de desenvolvimento antes de ir para a produção.
- Para problemas, consulte os logs do Kong.

Ao seguir este guia, você estará bem encaminhado para operacionalizar seus serviços de forma eficaz no Kong. Esperamos que esta documentação seja útil para você e sua equipe!

## Como Fazer em Produção

Até agora, focamos em como configurar Services e Routes para ambientes locais ou de desenvolvimento. Mas quando se trata de um ambiente de produção, as coisas podem ficar um pouco mais complicadas e exigem uma abordagem mais robusta.

Para gerenciamento de configuração em produção, recomendo o uso de uma ferramenta como o [Deck](https://github.com/Kong/deck). O Deck é uma CLI que ajuda a gerenciar a configuração do Kong de forma declarativa e pode se integrar com sistemas de CI/CD. Ele permite que você mantenha sua configuração em um estado consistente e faça o rollout de novas alterações de forma controlada e segura.

O Deck não apenas automatiza o processo, mas também fornece uma camada adicional de segurança e eficiência, garantindo que as configurações em seu ambiente de produção sejam aplicadas de maneira idêntica, evitando possíveis inconsistências ou erros humanos.

Isso deve ajudar a garantir que suas operações com o Kong sejam tão suaves quanto possível, independentemente do ambiente em que você esteja trabalhando.
