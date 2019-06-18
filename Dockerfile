FROM node:8-alpine

LABEL MAINTAINER elgranloky

#Only works in this version
#Related issue: https://github.com/FredrikNoren/ungit/issues/1115
ARG VERSION=1.4.26

RUN \
    echo "Installing bash, git and openssh" \
    && apk update \
    && apk add --no-cache git openssh bash \
    && echo "Installing ungit with npm" \
    && npm install -g ungit@${VERSION} \
    && echo "Cleaning apk..." \
    && apk del --progress --purge && rm -rf /var/cache/apk/* \
    && echo "ALL DONE"

COPY .ungitrc /root/.ungitrc

WORKDIR /git
VOLUME ["/git"]

EXPOSE 8448

COPY entry.sh /entry.sh
ENTRYPOINT ["/entry.sh"]

CMD ["/usr/local/bin/ungit"]
