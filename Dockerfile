
FROM marshallasch/base-resource:main

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

# setup the man pages
# RUN yes | unminimize

USER root

RUN wget https://www.csse.uwa.edu.au/programming/ansic-library.html -O /opt/static/docs/index.html

COPY database.sqlite /opt/wiki/database.sqlite

# install jupyter dependancies
RUN pip3 install jupyter-c-kernel

# Install jupyter kernels
RUN install_c_kernel --user

# copy all the builtin jupyter notebooks
COPY builtinNotebooks /builtin/jupyter
RUN chown -R ${UID}:${UID} /builtin /opt/static /opt/wiki

COPY motd.txt /scripts/
RUN chown -R ${UID}:${UID} /scripts

USER ${UNAME} 

# these two labels will change every time the container is built
# put them at the end because of layer caching
ARG VCS_REF
LABEL org.opencontainers.image.revision="${VCS_REF}"

ARG BUILD_DATE
LABEL org.opencontainers.image.created="${BUILD_DATE}"
