FROM registry.access.redhat.com/ubi9/go-toolset AS builder

COPY ./src/webdav.go ./webdav.go

RUN go mod init github.com/d0rc/webdav && go mod tidy && go build webdav.go

FROM registry.access.redhat.com/ubi9/ubi-minimal

COPY --from=builder /opt/app-root/src/webdav /app/webdav

USER 1001

VOLUME /data

EXPOSE 8080/tcp

CMD [ "/app/webdav" ]
