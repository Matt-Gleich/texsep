FROM golang:1.15-alpine3.12 AS builder

# Meta data:
LABEL maintainer="matthewgleich@gmail.com"
LABEL description="Separate your pdfs from your tex files"

# Copying over all the files:
COPY . /usr/src/app
WORKDIR /usr/src/app

# Installing dependencies/
RUN go get -v -t -d ./...

# Build the app
RUN go build -o app .

# hadolint ignore=DL3006,DL3007
FROM alpine:latest
COPY --from=builder /usr/src/app/app .
CMD ["./app"]
