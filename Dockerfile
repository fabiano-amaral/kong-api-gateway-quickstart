# Usar a imagem oficial do Kong como base
FROM kong:3

COPY plugins.yaml /plugins.yaml

# Pode ser feio e difícil de entender uma primeira vez
# mas é funcional para add plugins
RUN yq e '.plugins[] | "luarocks install \(.name) \(.version)"' /plugins.yaml | sh

USER root
# Copiar o script para o contêiner e permissão
COPY ./scripts/init-kong.sh /init-kong.sh
RUN chmod +x /init-kong.sh
USER 1000

COPY ./config /etc/kong/config

# Definir o script como o ponto de entrada
ENTRYPOINT ["/init-kong.sh"]
