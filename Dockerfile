FROM docker/compose:1.23.2

# cf.:
# - https://docs.docker.com/docker-cloud/builds/advanced/#environment-variables-for-building-and-testing
# - https://medium.com/microscaling-systems/labelling-automated-builds-on-docker-hub-f3d073fb8e1
# - https://docs.docker.com/docker-cloud/builds/advanced/#override-build-test-or-push-commands
ARG BUILD_DATE
ARG VCS_REF
ARG DOCKER_TAG

# cf.: http://label-schema.org/rc1/
LABEL author="Awesome Incremented <marcel.koertgen@gmail.com>"\
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.name="awesomeinc/docker.gitlab.monorepo" \
    org.label-schema.description="Base image to be used for Gitlab CI docker executor and monorepo support." \
    org.label-schema.usage="https://github.com/awesome-inc/docker.gitlab.monorepo/blob/master/README.md" \
    org.label-schema.url="https://hub.docker.com/r/awesomeinc/docker.gitlab.monorepo" \
    org.label-schema.vcs-url="https://github.com/awesome-inc/docker.gitlab.monorepo" \
    org.label-schema.vcs-ref="${VCS_REF}" \
    org.label-schema.vendor="Awesome Inc" \
    org.label-schema.version="${DOCKER_TAG}" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.docker.cmd="docker run awesomeinc/docker.gitlab.monorepo:${DOCKER_TAG}"

RUN apk add --no-cache bash curl jq

ENTRYPOINT [ "/bin/bash" ]

