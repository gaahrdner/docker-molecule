FROM alpine:3.6

LABEL Name=molecule Version=0.0.1

ENV DOCKER_COMPOSE_VERSION=1.16.0
ENV ANSIBLE_VERSION=2.4.0.0
ENV MOLECULE_VERSION=2.2.1

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    && apk --update --no-cache add \
        aufs-util \
        bash \
        ca-certificates \
        docker \
        git \
        iptables \
        python2 \
        py-pip \
        rsyslog \
    && apk --update --no-cache add --virtual \
        build-dependencies \
        build-base \
        libffi-dev \
        linux-headers \
        openssl-dev \
        python2-dev \
    && pip install --no-cache-dir --upgrade \
        pip \
        cffi \
    && pip install --no-cache-dir \
        ansible==${ANSIBLE_VERSION} \
        boto \
        boto3 \
        docker-compose==${DOCKER_COMPOSE_VERSION} \
        docker-py \
        dopy \
        molecule==${MOLECULE_VERSION} \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

ADD ./wrapdocker /usr/local/bin/wrapdocker

VOLUME /var/lib/docker
ENTRYPOINT ["wrapdocker"]
CMD ["/bin/bash"]
