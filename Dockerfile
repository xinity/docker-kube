FROM alpine:3.11.2

LABEL maintainer rachid zarouali <xinity77@gmail.com>

ENV KUBECTL_VERS=1.17 \
    DOCKER_CLI_VER=19.03.5

RUN addgroup -g 997 docker \
    && adduser -h /home/docker -u 997 -G docker -D -s /bin/bash docker

# download latest kubectl et docker client binary
RUN apk add --no-cache curl bash shadow \
    && curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERS}/bin/linux/amd64/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLI_VER}.tgz | tar xz docker/docker --strip-components 1 -C /usr/local/bin

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-kube.sh /root/.docker/cli-plugins/docker-kube
RUN chmod +x /usr/local/bin/docker-entrypoint.sh /root/.docker/cli-plugins/docker-kube
 

# USER docker

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]