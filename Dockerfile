FROM golang:1.10 AS builder

# Download and install the latest release of dep
#ADD https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 /usr/bin/dep
#RUN chmod +x /usr/bin/dep

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/github.com/mdlayher/apcupsd_exporter
#COPY Gopkg.toml Gopkg.lock ./
#RUN dep ensure --vendor-only
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /apcupsd_exporter .

FROM scratch
COPY --from=builder /apcupsd_exporter ./
ENTRYPOINT ["./apcupsd_exporter"]
