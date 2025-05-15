APP=$(shell basename $(shell git rev-parse --show-toplevel))
REGISTRY=nartur
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
USER=artur-nikitenko

# default linux amd64)
TARGETOS?=linux
TARGETARCH?=amd64

format:
	gofmt -s -w ./

lint:
	golangci-lint run

test:
	go test -v ./...

get:
	go mod tidy

build:
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o telegram-kbot-go -ldflags "-X=github.com/$(USER)/$(APP)/cmd.appVersion=$(VERSION)" main.go

image:
	docker build --build-arg VERSION=$(VERSION) -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH) .

push:
	docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	rm -f telegram-kbot-go
	docker rmi -f $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH) || true
