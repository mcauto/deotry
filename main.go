package main

import (
	"deotry/config"
	"deotry/logger"
	"fmt"
)

func main() {
	fmt.Println(config.Conf)
	logger.Std.Infoln(config.Conf.Name + "is Running")
	logger.Err.Errorln(config.Conf.Name + "is Running")
}
