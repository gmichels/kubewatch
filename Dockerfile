#------------------------------------------------------------------------------
# Set the base image for subsequent instructions:
#------------------------------------------------------------------------------

FROM alpine
MAINTAINER Gustavo Michels <gustavo.michels@gmail.com>

#------------------------------------------------------------------------------
# Environment variables:
#------------------------------------------------------------------------------

ENV GOPATH="/go"

#------------------------------------------------------------------------------
# Build and install:
#------------------------------------------------------------------------------

RUN apk add -U --no-cache -t dev git go musl-dev \
    && go get github.com/gmichels/kubewatch \
    && cp ${GOPATH}/bin/kubewatch /usr/local/bin \
    && apk del --purge dev && rm -rf /tmp/* /go

#------------------------------------------------------------------------------
# Entrypoint:
#------------------------------------------------------------------------------

ENTRYPOINT [ "kubewatch" ]
