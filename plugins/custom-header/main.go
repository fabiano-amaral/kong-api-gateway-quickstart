package main

import (
	"github.com/Kong/go-pdk"
	"github.com/Kong/go-pdk/server"
)

type Config struct {
	HeaderName  string `json:"header_name"`
	HeaderValue string `json:"header_value"`
}

func New() interface{} {
	return &Config{}
}

func (conf *Config) Access(kong *pdk.PDK) {
	kong.Response.SetHeader(conf.HeaderName, conf.HeaderValue)
}

func main() {
	server.StartServer(New, "0.1", 1000)
}
