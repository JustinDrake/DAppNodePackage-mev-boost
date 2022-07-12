FROM golang:1.18.3-alpine3.16 AS build

RUN apk add --update-cache \
        make \
        gcc \
        git \
	clang \
        libc-dev

WORKDIR /build
RUN git clone https://github.com/flashbots/mev-boost
WORKDIR /build/mev-boost
RUN make build

FROM golang:1.18.3-alpine3.16

COPY --from=build /build/mev-boost/mev-boost /mev-boost/mev-boost
WORKDIR /mev-boost
ENTRYPOINT ./mev-boost -addr 0.0.0.0:18550 -$NETWORK -relays $RELAYS