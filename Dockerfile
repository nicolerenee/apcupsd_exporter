FROM golang:1.10 AS builder

# Copy the code from the host and compile it
WORKDIR /go/src/github.com/mdlayher/apcupsd_exporter
COPY . ./
RUN go get -d ./...
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /apcupsd_exporter cmd/apcupsd_exporter/main.go

FROM scratch
COPY --from=builder /apcupsd_exporter ./
ENTRYPOINT ["./apcupsd_exporter"]
