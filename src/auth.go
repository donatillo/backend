package main

import (
    "encoding/json"
    "github.com/futurenda/google-auth-id-token-verifier"
    "net/http"
    "time"
)

type UserData struct {
    Id          string      `json:"id"`
    Name        string      `json:"name,omitempty"`
    Email       string      `json:"email,omitempty"`
    Picture     string      `json:"picture,omitempty"`
    Expiration  time.Time   `json:"expiration"`
    Issuer      string      `json:"issuer"`
}

func PostAuthenticate(w http.ResponseWriter, r *http.Request) {
    w.Header().Set("Content-Type", "application/json")   // TODO can we move this to a central location?

    // receive parameter
    type Token struct {
        Token string `json:"token"`
    }
    var t Token;
    err := json.NewDecoder(r.Body).Decode(&t)
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    // send response
    user, err := interpretToken(t.Token, false);
    if err != nil {
        http.Error(w, err.Error(), http.StatusUnauthorized)
        return
    }
    json.NewEncoder(w).Encode(user)
}

func interpretToken(token string, ignore_expiration bool) (UserData, error) {
    v := googleAuthIDTokenVerifier.Verifier{}
    aud := "811389324926-r7avgrieateldgm2sbg9oudu10ulsrho.apps.googleusercontent.com"  // TODO - put this in a config file
    err := v.VerifyIDToken(token, []string{ aud, })
    if err == nil || (ignore_expiration && err == googleAuthIDTokenVerifier.ErrTokenUsedTooLate) {
        claims, err := googleAuthIDTokenVerifier.Decode(token)
        if err != nil {
            return UserData{}, err
        }
        return UserData{
            claims.Sub,
            claims.GivenName + " " + claims.FamilyName,
            claims.Email,
            claims.Picture,
            time.Unix(claims.Exp, 0),
            "google",
        }, nil
    }
    return UserData{}, err
}

// vim:ts=4:sts=4:sw=4:expandtab
