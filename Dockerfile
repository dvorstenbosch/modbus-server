FROM alpine:3.20.3

LABEL maintainer="Hoppenbrouwers Techniek"
LABEL site.local.program.version="1.0.0"

RUN apk upgrade --available --no-cache --update \
    && apk add --no-cache --update \
       python3=3.12.7-r0 \
       py3-pip=24.0-r2 \
    # Cleanup APK
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

COPY --chown=root:root /src /

RUN pip3 install --no-cache-dir -r /requirements.txt --break-system-packages

EXPOSE 5020/tcp
EXPOSE 5020/udp

USER 1434:1434

# Start Server
ENTRYPOINT ["python", "-u", "/app/modbus_server.py"]
