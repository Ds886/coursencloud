FROM nginx:alpine-slim
RUN apk add curl
HEALTHCHECK --interval=30s --timeout=10s CMD curl -sf http://localhost >/dev/null || exit 1 ]
# HEALTHCHECK --interval=30s --timeout=10s CMD exit 1

