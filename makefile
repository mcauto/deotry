
PKG_LIST := $(shell go list ./... | grep -v /vendor/)
GO_FILES := $(shell find . -name '*.go' | grep -v /vendor/ | grep -v _test.go)

GREEN := \033[0;32m
NC := \033[0;m

all: clean dep fmt lint vet goreport setup test race coverage 

# Run gofmt
fmt:
	@echo  "${GREEN}Fix by golang format${NC}"
	@gofmt -l -w ${GO_FILES}

# Check gofmt
fmtcheck:
	@echo "${GREEN}Check gofmt${NC}"
	@gofmt -l -s ${GO_FILES} | read; \
	if [ $$? == 0 ]; \
		then echo "gofmt check failed for:"; \
		gofmt -l -s ${GO_FILES}; \
		exit 1; \
	fi

# Lint check
lint: 
	@echo "${GREEN}Start golint${NC}"
	@golint -set_exit_status ${PKG_LIST}

vet:
	@go vet ./...

# Check goreportcard-cli
# (require) 1. https://github.com/alecthomas/gometalinter
#				@curl -L https://git.io/vp6lP | sh # Linux
#				@brew tap alecthomas/homebrew-tap & brew install gometalinter # MacOS
#			2. https://github.com/gojp/goreportcard
goreport:
	@go get -u github.com/gojp/goreportcard/cmd/goreportcard-cli
	@echo "${GREEN}Run goreportcard-cli${NC}"
	@goreportcard-cli

# Infra init
setup:
	@echo "${GREEN}Run infrastructure${NC}"
	@docker-compose up -d
	@printf "${GREEN}Mysql running"
	@bash ./tools/mysql_check.sh go_mysql root imdeo

# Run unittests
test:
	@echo "${GREEN}Start test${NC}"
	@go test -short ${PKG_LIST}

# Run data race detector
race:
	@echo "${GREEN}Run data race detector${NC}"
	@go test -race -short ${PKG_LIST}


# Make code coverage report 
# (require) https://github.com/axw/gocov
coverage:
	@go get -u github.com/axw/gocov
	@echo "${GREEN}Check code coverage${NC}"
	@gocov test ${PKG_LIST} | gocov report 

# Dependency installation
dep:
	@echo "${GREEN}Install dependency${NC}"
	@dep ensure

clean:
	@echo "${GREEN}Clean project${NC}"
	@docker-compose down
	@rm -rf vendor
	@go clean

.PHONY: all fmt fmtcheck lint vet goreport setup test race coverage dep clean