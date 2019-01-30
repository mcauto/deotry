package main

import (
	"deotry/config"
	"deotry/logger"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/mcauto/daemon"
)

const (
	name        = "deotry"
	description = "go seed project"
)

var (
	dependencies   = []string{""}
	message        string
	err            error
	stdlog, errlog *log.Logger
)

// Service daemon
type Service struct {
	daemon.Daemon
}

func init() {
	stdlog = log.New(os.Stdout, "", log.Ldate|log.Ltime)
	errlog = log.New(os.Stderr, "", log.Ldate|log.Ltime)
}

// Manage by daemon commands or run the daemon
func (service *Service) Manage() (string, error) {

	usage := "Usage: myservice install | remove | start | stop | status"

	// if received any kind of command, do it
	if len(os.Args) > 1 {
		command := os.Args[1]
		switch command {
		case "install":
			return service.Install()
		case "remove":
			return service.Remove()
		case "start":
			return service.Start()
		case "stop":
			return service.Stop()
		case "status":
			return service.Status()
		default:
			return usage, nil
		}
	}
	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt, os.Kill, syscall.SIGTERM)
	t := time.NewTicker(time.Second * 3)
MAIN:
	for {
		select {
		case <-t.C:
			message = config.Conf.Name + " is Running"
			fmt.Println(message)
			logger.Std.Infoln(message)
		case sig := <-interrupt:
			switch sig {
			case os.Kill:
				message = "Kill process"
				logger.Std.Errorln(message)
				err = nil
				break MAIN
			case os.Interrupt:
				fallthrough
			default:
				message = sig.String()
				break MAIN
			}
		}
	}

	return message, err
}

func main() {
	srv, err := daemon.New(name, description, dependencies...)
	if err != nil {
		logger.Std.Errorln("Error: ", err)
		errlog.Println("Error: ", err)
		os.Exit(1)
	}
	service := &Service{srv}
	status, err := service.Manage()
	if err != nil {
		logger.Std.Errorln(status, "\nError: ", err)
		errlog.Println(status, "\nError: ", err)
		os.Exit(1)
	}
	fmt.Println(status)
}
