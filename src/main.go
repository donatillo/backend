package main

import (
    "log"
    "net/http"
    "github.com/gorilla/mux"
)

func main() {
    router := mux.NewRouter()
    router.HandleFunc("/authenticate", PostAuthenticate).Methods("POST")
    log.Fatal(http.ListenAndServe(":8000", router));
}

// vim:ts=4:sts=4:sw=4:expandtab
