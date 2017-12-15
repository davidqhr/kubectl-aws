FROM alpine

MAINTAINER David <davidqhr@gmail.com>

ARG VCS_REF
ARG BUILD_DATE

ENV KUBE_LATEST_VERSION="v1.8.4"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

RUN \
 mkdir -p /aws && \
 apk -Uuv add groff less python py-pip && \
 pip install awscli && \
 apk --purge -v del py-pip && \
 rm /var/cache/apk/*