package main

import (
    "log"
    "net/http"
    "os"
    "github.com/gorilla/mux"
    "github.com/gorilla/handlers"
)

func main() {
    router := mux.NewRouter()
    router.HandleFunc("/authenticate", PostAuthenticate).Methods("POST")
    loggedRouter := handlers.LoggingHandler(os.Stdout, router)
    log.Fatal(http.ListenAndServe(":8000", loggedRouter));
}

// vim:ts=4:sts=4:sw=4:expandtab
