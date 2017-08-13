FROM ubuntu:14.04
MAINTAINER Luandro <luandro@gmail.com>
LABEL name="dathttpd"

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y nodejs npm
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

COPY ./scripts/buildConfig.js ~/buildConfig.js

RUN apt-get update && apt-get install libtool m4 automake
RUN npm install -g dathttpd
RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\``
RUN node -v
CMD ["dathttpd"]
RUN node ~/buildConfig.js

EXPOSE 80
EXPOSE 443
