ARG UPSTREAM_VERSION
FROM flashbots/mev-boost:${UPSTREAM_VERSION}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY mainnet /mainnet
COPY goerli /goerli

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]