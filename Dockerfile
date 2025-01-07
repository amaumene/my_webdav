FROM golang AS builder

RUN git clone https://github.com/bits0rcerer/go-dav.git /app

WORKDIR /app

RUN rm go.mod go.sum

RUN go mod init github.com/bits0rcerer/go-dav && go mod tidy

RUN CGO_ENABLED=0 go build -o webdav main.go

FROM scratch

COPY --chown=65532 --from=builder /app/webdav /app/webdav

VOLUME /data

EXPOSE 8080/tcp

CMD [ "/app/webdav" ]
