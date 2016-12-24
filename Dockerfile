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

FROM bitnami/node

RUN git clone -b dev-master https://github.com/jaydengorout/base_app.git /tmp/app &&
    mv /tmp/app/src/* /app &&
    npm install

EXPOSE 3000
CMD ["npm", "start"]