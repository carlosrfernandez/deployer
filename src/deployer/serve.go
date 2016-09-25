package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

func _describe (w http.ResponseWriter, r *http.Request) {
    Describe(true)
}

func serve() (errorCode int){
    http.HandleFunc("/", handler)
    http.HandleFunc("/describe", _describe)
    http.ListenAndServe(":80", nil)
    errorCode = 0
    return
}
