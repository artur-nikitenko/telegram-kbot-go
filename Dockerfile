FROM quay.io/projectquay/golang:1.24 as builder

WORKDIR /go/src/app
COPY . .
RUN make linux

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/build/linux-amd64/telegram-kbot-go .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["./telegram-kbot-go"]
