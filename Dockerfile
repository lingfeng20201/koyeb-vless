FROM alpine:3.20

RUN apk add --no-cache curl unzip ca-certificates tzdata nginx && \
    ARCH=$(uname -m) && \
    case "$ARCH" in \
      aarch64|arm64) XZ="arm64-v8a" ;; \
      *)             XZ="64" ;; \
    esac && \
    curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${XZ}.zip" && \
    unzip -o /tmp/xray.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/xray && \
    rm -f /tmp/xray.zip && \
    mkdir -p /etc/xray /run/nginx

COPY config.json /etc/xray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8000
CMD ["/start.sh"]
