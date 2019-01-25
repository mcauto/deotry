package model

import (
	"deotry/config"
	"fmt"
	"testing"
)

func TestConnectDB(t *testing.T) {
	url := config.Conf.Database.GetURL()
	fmt.Println(url)
	_, err := ConnectDB(url)
	if err != nil {
		t.Error(err)
	}
}
