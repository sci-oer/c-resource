
FROM marshallasch/base-resource:sha-6ae2b4c

LABEL org.opencontainers.version="v1.0.0"

LABEL org.opencontainers.image.authors="Marshall Asch <masch@uoguelph.ca> (https://marshallasch.ca)"
LABEL org.opencontainers.image.url="https://github.com/sci-oer/c-resource.git"
LABEL org.opencontainers.image.source="https://github.com/sci-oer/c-resource.git"
LABEL org.opencontainers.image.vendor="University of Guelph School of Computer Science"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.title="Java Offline Course Resouce"
LABEL org.opencontainers.image.description="This image is the C specific image that can be used to act as an offline resource for students to contain all the instructional matrial and tools needed to do the course content"

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
