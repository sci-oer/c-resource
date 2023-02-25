
FROM scioer/base-resource:sha-40bb95e

LABEL org.opencontainers.version="v1.0.0"

LABEL org.opencontainers.image.authors="Marshall Asch <masch@uoguelph.ca> (https://marshallasch.ca)"
LABEL org.opencontainers.image.source="https://github.com/sci-oer/c-resource.git"
LABEL org.opencontainers.image.vendor="sci-oer"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.title="C Offline Course Resouce"
LABEL org.opencontainers.image.description="This image is the C specific image that can be used to act as an offline resource for students to contain all the instructional matrial and tools needed to do the course content"
LABEL org.opencontainers.image.base.name="registry-1.docker.io/scioer/base-resource:sha-40bb95e"


ARG VERSION=v1.0.0
LABEL org.opencontainers.image.version="$VERSION"

USER root

COPY docs/ansic-library.html /opt/static/docs/index.html
RUN chown -R ${UID}:${UID} /opt/static

# install jupyter dependancies
RUN pip3 install jupyter-c-kernel

# Install jupyter kernels
RUN install_c_kernel --user

USER ${UNAME}

# these two labels will change every time the container is built
# put them at the end because of layer caching
ARG VCS_REF
LABEL org.opencontainers.image.revision="${VCS_REF}"

ARG BUILD_DATE
LABEL org.opencontainers.image.created="${BUILD_DATE}"
