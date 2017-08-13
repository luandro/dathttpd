FROM nodesource/jessie:argon
MAINTAINER Luandro <luandro@gmail.com>
LABEL name="dathttpd"

COPY ./scripts/buildConfig.js ~/buildConfig.js

RUN apt-get install libtool m4 automake
RUN npm install -g dathttpd
RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\``
CMD ["dathttpd"]
RUN node ~/buildConfig.js

EXPOSE 80
EXPOSE 443
