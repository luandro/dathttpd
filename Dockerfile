FROM ubuntu:14.04
MAINTAINER Luandro <luandro@gmail.com>
LABEL name="dathttpd"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
  && apt-get install -y libtool m4 automake supervisor python nodejs git openssl build-essential ca-certificates \
  && npm install -g npm@latest \
  && npm update \
  && apt-get update --fix-missing \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && apt-get autoremove -y \
  && ln -s /usr/bin/nodejs /usr/local/bin/node \
  && node -v
  && npm install -g dathttpd --allow-root \
  && setcap cap_net_bind_service=+ep `readlink -f \`which node\`` \
  && node -v
COPY ./scripts/buildConfig.js ~/buildConfig.js
RUN node ~/buildConfig.js
CMD ["dathttpd"]

EXPOSE 80
EXPOSE 443
