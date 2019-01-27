# Deotry

[![Go Report Card](https://goreportcard.com/badge/github.com/mcauto/deotry)](https://goreportcard.com/report/github.com/mcauto/deotry)
[![Build Status](https://travis-ci.org/mcauto/deotry.svg?branch=master)](https://travis-ci.org/mcauto/deotry)
[![Coverage Status](https://coveralls.io/repos/github/mcauto/deotry/badge.svg?branch=develop)](https://coveralls.io/github/mcauto/deotry?branch=develop)

Deotry is golang seed project



## How to start

``` bash
make
```



## Project structure
- [x] Split configuration ([viper](https://github.com/spf13/viper), [go build constraints](https://golang.org/pkg/go/build/#hdr-Build_Constraints)) 
- [x] Database connect ([gorm](https://github.com/jinzhu/gorm))
- [x] Code Quality Check
  - [x] Gofmt
  - [x] Golint
  - [x] Vet
  - [x] Unittests
  - [x] Code coverage([gocov](https://github.com/axw/gocov))
  - [x] Go report card([goreportcard-cli](github.com/gojp/goreportcard/cmd/goreportcard-cli))
- [x] Dependency management ([dep][https://github.com/jinzhu/gorm])
- [x] Logging ([distillog](https://github.com/amoghe/distillog), [lumberjack](https://github.com/natefinch/lumberjack))
  - [x] Rotate file
