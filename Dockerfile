# Usar a imagem oficial do Kong como base
FROM kong:3

# Copie o arquivo de plugins para o contêiner
COPY plugins.yaml /plugins.yaml

# Instale os plugins listados no arquivo plugins.yaml
RUN yq e '.plugins[] | "luarocks install \(.name) \(.version)"' /plugins.yaml | sh

# Copiar o script para o contêiner e permissão
COPY ./scripts/init-kong.sh /init-kong.sh
RUN chmod +x /init-kong.sh


RUN chown -R kong:kong /certs

COPY ./config /etc/kong/config

# Definir o script como o ponto de entrada
ENTRYPOINT ["/init-kong.sh"]
