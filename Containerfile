# official image (fedora-based) only available for amd64 & arm64:
# https://web.archive.org/web/20241221195029/https://hub.docker.com/r/matrixcommander/matrix-commander/tags
# https://web.archive.org/web/20241221195137/https://raw.githubusercontent.com/8go/matrix-commander/refs/tags/v8.0.4/.github/workflows/docker-publish.yml
# https://web.archive.org/web/20241221202135/https://raw.githubusercontent.com/8go/matrix-commander/refs/tags/v8.0.4/docker/Dockerfile

FROM docker.io/alpine:3.20.3

RUN apk add --no-cache \
        py3-atomicwrites=~1.4 \
        py3-magic=~0.4 \
        py3-matrix-nio=~0.24 \
        py3-notify2=~0.3 \
        py3-olm=~3.2 \
        py3-pillow=~10.3 \
        py3-pip=~24.0 \
        py3-xdg=~0.28 \
        py3-peewee=~3.17 \
        py3-emoji=~2.12 \
        py3-markdown=~3.6 \
        py3-zope-interface=~6.0 \
        py3-cachetools=~5.3 \
    && pip install --no-deps --break-system-packages --no-cache-dir \
        uuid==1.30

ARG MATRIX_COMMANDER_VERSION=8.0.4
# alpine's pip does not support "--hash"
RUN pip install --no-deps --break-system-packages --no-cache-dir \
        matrix-commander==${MATRIX_COMMANDER_VERSION} \
    && matrix-commander --version `# import test`

# random uid & gid to avoid accidental invocation as 0:0. to be overwritten.
USER 22139:35765

# https://github.com/opencontainers/image-spec/blob/v1.0.1/annotations.md
LABEL org.opencontainers.image.title="8go's matrix-commander on alpine" \
    org.opencontainers.image.source="https://github.com/fphammerle/matrix-commander-container-image"
