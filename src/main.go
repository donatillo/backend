package main

import (
    "log"
    "net/http"
    "os"
    "github.com/gorilla/mux"
    "github.com/gorilla/handlers"
    "github.com/rs/cors"
)

func main() {
    router := mux.NewRouter()
    router.HandleFunc("/authenticate", PostAuthenticate).Methods("POST")
    loggedRouter := handlers.LoggingHandler(os.Stdout, router)
    handler := cors.Default().Handler(loggedRouter);
    log.Fatal(http.ListenAndServe(":8000", handler));
}

// vim:ts=4:sts=4:sw=4:expandtab
