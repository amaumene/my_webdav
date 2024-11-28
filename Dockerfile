FROM golang AS builder

WORKDIR /app

COPY ./src/webdav.go ./webdav.go

RUN go mod init github.com/amaumene/my_webdav && go mod tidy

RUN CGO_ENABLED=0 go build webdav.go

FROM scratch

COPY --chown=65532 --from=builder /app/webdav /app/webdav

VOLUME /data

EXPOSE 8080/tcp

CMD [ "/app/webdav" ]
