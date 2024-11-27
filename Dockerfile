FROM golang AS builder

WORKDIR /app

COPY ./src/webdav.go ./webdav.go

RUN go mod init github.com/amaumene/my_webdav && go mod tidy && go build webdav.go

RUN CGO_ENABLED=0 go build webdav.go

FROM gcr.io/distroless/static:nonroot

COPY --chown=nonroot --from=builder /app/webdav /app/webdav

VOLUME /data

EXPOSE 8080/tcp

CMD [ "/app/webdav" ]
