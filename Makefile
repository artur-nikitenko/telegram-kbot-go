APP=$(shell basename $(shell git rev-parse --show-toplevel))
USER=artur-nikitenko
REGISTRY=ghcr.io/$(USER)
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# default linux amd64
TARGETOS?=linux
TARGETARCH?=amd64
PLATFORM_SUFFIX=$(TARGETOS)-$(TARGETARCH)
FULL_VERSION=$(VERSION)-$(PLATFORM_SUFFIX)

format:
	gofmt -s -w ./

lint:
	golangci-lint run

test:
	go test -v ./...

get:
	go mod tidy

linux:
	GOOS=linux GOARCH=amd64 make build-binary TARGETOS=linux TARGETARCH=amd64

arm:
	GOOS=linux GOARCH=arm64 make build-binary TARGETOS=linux TARGETARCH=arm64

macos:
	GOOS=darwin GOARCH=amd64 make build-binary TARGETOS=darwin TARGETARCH=amd64

windows:
	GOOS=windows GOARCH=amd64 make build-binary TARGETOS=windows TARGETARCH=amd64

build-binary:
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o build/$(TARGETOS)-$(TARGETARCH)/telegram-kbot-go -ldflags "-X=github.com/$(USER)/$(APP)/cmd.appVersion=$(VERSION)" main.go
#	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o telegram-kbot-go -ldflags "-X=github.com/$(USER)/$(APP)/cmd.appVersion=$(VERSION)" main.go

#image:
#	docker build --build-arg VERSION=$(VERSION) --platform=linux/$(TARGETARCH) -t $(REGISTRY)/$(APP):$(FULL_VERSION) .
image:
	docker build --build-arg VERSION=$(FULL_VERSION) --platform=linux/$(TARGETARCH) -t $(REGISTRY)/$(APP):$(FULL_VERSION) .
push:
	docker push $(REGISTRY)/$(APP):$(FULL_VERSION)

clean:
	rm -rf build
	docker rmi -f $(REGISTRY)/$(APP):$(VERSION)-$(PLATFORM_SUFFIX) || true
