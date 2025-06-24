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

# Criar o diretório de sockets e ajustar permissões para o usuário 'kong'
# O usuário 'kong' (UID 999) é o usuário padrão que o processo Kong executa como na imagem base.
RUN mkdir -p /usr/local/kong/sockets && \
    chown -R kong:kong /usr/local/kong && \
    chmod -R u+rwx /usr/local/kong # Garante que o proprietário (kong) tenha rwx


COPY ./config /etc/kong/config

# Definir o script como o ponto de entrada
ENTRYPOINT ["/init-kong.sh"]
