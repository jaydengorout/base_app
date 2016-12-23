## BUILDING
##   (from project root directory)
##   $ docker build -t node-js-for-jaydengorout-base_app .
##
## RUNNING
##   $ docker run -p 3000:3000 node-js-for-jaydengorout-base_app
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r7

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="gp67qfa" \
    STACKSMITH_STACK_NAME="Node.js for jaydengorout/base_app" \
    STACKSMITH_STACK_PRIVATE="1"

# Install required system packages
RUN install_packages libc6 libssl1.0.0 libncurses5 libtinfo5 zlib1g libbz2-1.0 libreadline6 libstdc++6 libgcc1 ghostscript imagemagick libmysqlclient18

RUN bitnami-pkg install node-6.9.2-0 --checksum ec301fcb1da238bade5d1c4107a487f6da77eb8b5479f7151ba83aa25d008fab

ENV PATH=/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH \
    NODE_PATH=/opt/bitnami/node/lib/node_modules

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating
WORKDIR ./app

RUN npm install

EXPOSE 3000
CMD ["npm", "start"]