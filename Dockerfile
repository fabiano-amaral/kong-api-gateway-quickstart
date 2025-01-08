# Build the Go plugin
FROM golang:1.23 AS builder

WORKDIR /go/src/custom-header
COPY ./plugins/custom-header .

# Build the custom-header plugin
RUN go build -o custom-header .


# Use the official Kong image
FROM kong:3

# Copy the plugin configuration
COPY plugins.yaml /plugins.yaml

# Install plugins from plugins.yaml
RUN yq e '.plugins[] | "luarocks install \(.name) \(.version)"' /plugins.yaml | sh

USER root

RUN mkdir -p /usr/local/kong-go/custom-header \
    && chown -R 1000:1000 /usr/local/kong-go

COPY --from=builder /go/src/custom-header/custom-header /usr/local/bin/custom-header

COPY ./scripts/init-kong.sh /init-kong.sh
RUN chmod +x /init-kong.sh
USER 1000

COPY ./config /etc/kong/config

# Set the entrypoint
ENTRYPOINT ["/init-kong.sh"]
