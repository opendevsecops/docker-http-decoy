FROM golang:alpine as build

WORKDIR /build

RUN true \
	&& apk --no-cache add \
		git

RUN true \
	&& go get -u github.com/opendevsecops/go-http-decoy

# ---

FROM alpine:latest

WORKDIR /run

COPY --from=build /go/bin/go-http-decoy /bin/http-decoy

WORKDIR /session

ENTRYPOINT ["/bin/http-decoy"]
