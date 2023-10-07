# Kong API Gateway Versão 3 com Docker Compose

## Índice

1. [Visão Geral](#visão-geral)
2. [Pré-requisitos](#pré-requisitos)
3. [Estrutura de Pastas](#estrutura-de-pastas)
4. [Instalação](#instalação)
5. [Configuração](#configuração)
    - [Plugins](#plugins)
    - [Services e Routes](#services-e-routes)
6. [Uso](#uso)
7. [Troubleshooting](#troubleshooting)
8. [Contribuições](#contribuições)
9. [Licença](#licença)

**Cada pasta possui seu próprio README detalhado**

## Visão Geral

Este projeto fornece uma implementação rápida e eficiente do Kong, uma plataforma de API Gateway altamente escalável e flexível. Kong é construído sobre o Nginx e fornece uma solução robusta para gerenciar o acesso a suas APIs REST, bem como outras funcionalidades como balanceamento de carga, autenticação, taxa de limite, logging e muito mais.

O objetivo deste projeto é oferecer uma configuração simplificada, porém robusta, do Kong através do Docker Compose. Isso facilita o desenvolvimento e o teste de APIs, permitindo que você foque na lógica do seu serviço, enquanto o Kong cuida de todas as complexidades relacionadas ao tráfego de entrada e saída.

Este projeto é particularmente útil para desenvolvedores e equipes que desejam um ponto de partida sólido para trabalhar com Kong em um ambiente de desenvolvimento ou teste. Ele é focado na versão 3 do Kong e foi projetado para ser o mais simples possível, permitindo fácil personalização e expansão conforme necessário.

## Pré-requisitos

- Docker
- Docker Compose

## Estrutura de Pastas

```
.
├── certs
├── config
│   ├── plugins
│   │   └── rate-limit.yaml
│   └── services
│       └── example.yaml
├── docker-compose.yaml
├── Dockerfile
├── plugins.yaml
└── scripts
    └── init-kong.sh
```

## Modelo Híbrido com Kong

### O que é o Modelo Híbrido?

O modelo híbrido é um recurso do Kong que permite dividir suas instâncias em dois tipos de planos: Control Plane (CP) e Data Plane (DP). 

- **Control Plane (CP)**: É responsável por todo o gerenciamento da sua infraestrutura Kong. Ele mantém a configuração, os plugins e quaisquer outros aspectos que afetem a lógica de roteamento, mas não lida diretamente com o tráfego da API.
  
- **Data Plane (DP)**: Este é o plano que efetivamente lida com o tráfego da API. Ele recebe todas as requisições e as roteia com base nas instruções fornecidas pelo Control Plane.

### Por que usar o Modelo Híbrido?

- **Escalabilidade**: Como o Data Plane e o Control Plane são desacoplados, você pode escalar cada um deles independentemente, de acordo com suas necessidades.
  
- **Segurança**: O Data Plane pode ser exposto à internet, enquanto o Control Plane pode ser mantido em uma rede segura.

- **Gerenciamento Centralizado**: Todas as configurações são armazenadas e gerenciadas no Control Plane, tornando mais fácil gerenciar múltiplas instâncias do Data Plane.

## Instalação

Clone o repositório:

```bash
git clone https://github.com/fabiano-amaral/kong-api-gateway-quickstart.git
```

Navegue até a pasta do projeto:

```bash
cd kong-api-gateway-quickstart
```

Construa e levante os serviços com Docker Compose:

```bash
docker-compose up --build -d
```

## Configuração

### Plugins

#### Instalação de Plugins

O arquivo `plugins.yaml` na raiz do projeto é utilizado especificamente para a instalação de novos plugins do Kong. Ele não é usado para ativar ou configurar esses plugins para serviços específicos. Nesse arquivo, você deve listar todos os plugins que deseja instalar, indicando também suas respectivas versões.

Exemplo:

```yaml
plugins:
  - name: "kong-plugin-rate-limiting"
    version: "2.0.0"
```

Ao construir sua imagem Docker com este arquivo na raiz, os plugins listados serão instalados.

#### Ativação e Configuração de Plugins

Para a ativação e configuração de plugins em serviços específicos, você deve utilizar os arquivos YAML dentro da pasta `config/plugins/`. Cada arquivo YAML nesse diretório deve conter as configurações para um ou mais plugins que você deseja ativar ou configurar.

Por exemplo, um arquivo `config/plugins/rate-limit.yaml` pode conter:

```yaml
_format_version: "3.0"
_transform: false

plugins:
- name: rate-limiting
  config:
    second: 5
```

Esses arquivos são usados para configurar como os plugins funcionarão em relação aos seus serviços, mas não para instalá-los. A instalação, como mencionado, é gerenciada pelo `plugins.yaml` na raiz do projeto.

### Serviços e Rotas

#### Definição de Serviços

Para definir os serviços que o Kong deve gerenciar, você vai utilizar arquivos YAML dentro da pasta `config/services/`. Cada arquivo deve conter a configuração para um ou mais serviços que você deseja expor via Kong.

Por exemplo, o arquivo `config/services/example.yaml` pode ter o seguinte conteúdo:

```yaml
_format_version: "3.0"
_transform: false

services:
- name: meu-servico
  url: https://mockbin.org
```

Neste exemplo, um serviço chamado `meu-servico` é definido e aponta para a URL `https://mockbin.org`.

#### Definição de Rotas

As rotas associadas aos serviços são também configuradas dentro dos arquivos YAML em `config/services/`. Dentro de cada configuração de serviço, você pode definir múltiplas rotas.

Ajustando o exemplo anterior, o arquivo `config/services/example.yaml` poderia ser expandido para:

```yaml
_format_version: "3.0"
_transform: false

services:
- name: meu-servico
  url: https://mockbin.org
  routes:
  - name: rota-para-meu-servico
    paths:
    - "/meu-servico"
```

Aqui, uma rota chamada `rota-para-meu-servico` é adicionada ao serviço `meu-servico`. Qualquer requisição a Kong com o caminho `/meu-servico` será encaminhada para `https://mockbin.org`.

### Resumo

- **Para instalar novos plugins**: Use o arquivo `plugins.yaml` na raiz do projeto.
- **Para configurar e ativar plugins em serviços específicos**: Use os arquivos dentro de `config/plugins/`.
- **Para definir serviços e suas respectivas rotas**: Use os arquivos dentro de `config/services/`.

Essa organização garante que a configuração do seu ambiente Kong seja modular, tornando mais fácil gerenciar serviços e plugins separadamente.

## Uso

Uma vez que você tenha inicializado todos os serviços usando o Docker Compose, várias interfaces estarão disponíveis para interação e administração do Kong. A seguir estão as mais relevantes:

- **Kong Admin API**: Acessível via `http://localhost:8001`, esta é a API administrativa que você usará para todas as operações programáticas no Kong. Seja para adicionar novos serviços, rotas ou para ativar plugins, tudo pode ser feito aqui através de chamadas RESTful.

- **Kong Admin GUI**: Esta é a interface gráfica do usuário e pode ser acessada através de `http://localhost:8002`. A GUI oferece uma maneira mais visual e interativa para gerenciar os aspectos do seu gateway API. Ele é especialmente útil para visualizar o fluxo de tráfego, modificar configurações existentes ou adicionar novas funcionalidades de forma mais intuitiva.

Ambas as interfaces são destinadas a administradores e devem ser protegidas adequadamente em ambientes de produção. Se você está apenas começando, a Admin GUI pode ser um excelente ponto de partida para entender como tudo funciona. À medida que você se familiarizar com o sistema, é provável que passe a utilizar a Admin API para integrações mais avançadas e automações.

## Troubleshooting

Se você encontrar problemas ao usar este ambiente Kong, a primeira coisa a fazer é conferir os logs dos contêineres em questão. Isso pode ser feito usando `docker logs <container_name>`. Além disso, as interfaces de administração podem fornecer informações úteis sobre a configuração atual e o estado dos plugins e serviços. Se você suspeitar de problemas com plugins específicos, verifique se eles estão corretamente listados e ativados tanto na Admin API quanto na GUI. Certifique-se também de que a estrutura de pastas e os arquivos YAML estão corretamente formatados e localizados nos lugares corretos.

## Contribuições

Contribuições são bem-vindas! Abra uma issue ou um Pull Request.

## Licença

Este projeto está sob a licença MIT. Consulte o arquivo [LICENSE.md](LICENSE.md) para mais detalhes.
