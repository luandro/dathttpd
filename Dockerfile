FROM ubuntu:16.04
MAINTAINER Luandro <luandro@gmail.com>
LABEL name="dathttpd"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
  && apt-get install -y libtool m4 automake supervisor python nodejs imagemagick git openssl make build-essential gcc ca-certificates \
  && npm install -g npm@latest \
  && npm install -g express-generator bower mocha sinon should assert node-gyp \
  && npm update \
  && apt-get update --fix-missing \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && apt-get autoremove -y \
  && ln -s /usr/bin/nodejs /usr/local/bin/node

RUN npm install -g dathttpd && setcap cap_net_bind_service=+ep `readlink -f \`which node\``
RUN node -v
COPY ./scripts/buildConfig.js ~/buildConfig.js
CMD ["dathttpd"]
RUN node ~/buildConfig.js

EXPOSE 80
EXPOSE 443
