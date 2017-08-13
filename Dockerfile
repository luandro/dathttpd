FROM ubuntu:16.04
MAINTAINER Luandro <luandro@gmail.com>
LABEL name="dathttpd"

RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y \
    libtool \
    m4 \
    automake \
    nodejs \
    build-essential
RUN npm install -g dathttpd
RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\``
RUN node -v
COPY ./scripts/buildConfig.js ~/buildConfig.js
CMD ["dathttpd"]
RUN node ~/buildConfig.js

EXPOSE 80
EXPOSE 443
