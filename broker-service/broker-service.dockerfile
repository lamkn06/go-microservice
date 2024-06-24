# bas go image
FROM golang:1.18-alpine AS builder

RUN mkdir /app

COPy . /app

WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp

# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD ["/app/brokerApp"]