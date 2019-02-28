package main

import (
    "testing"
    "gotest.tools/assert"
    is "gotest.tools/assert/cmp"
    "time"
)

func TestToken(t *testing.T) {
    token := `eyJhbGciOiJSUzI1NiIsImtpZCI6ImYyNGQ2YTE5MzA2NjljYjc1ZjE5NzBkOGI3NTRhYTE5M2YwZDkzMWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiODExMzg5MzI0OTI2LXI3YXZncmllYXRlbGRnbTJzYmc5b3VkdTEwdWxzcmhvLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiODExMzg5MzI0OTI2LXI3YXZncmllYXRlbGRnbTJzYmc5b3VkdTEwdWxzcmhvLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTAxNzM4NTg2MDUwNjcyMzg4MTYzIiwiZW1haWwiOiJhbmRyZS5uaG9AZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJQR2g3UVhyTzVMT1ZtcWRGUVZDOW1RIiwibmFtZSI6IkFuZHLDqSBXYWduZXIiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDUuZ29vZ2xldXNlcmNvbnRlbnQuY29tLy0zWEpSZjZnWVR0SS9BQUFBQUFBQUFBSS9BQUFBQUFBQUNGby9KNXAxaXJQQTRyRS9zOTYtYy9waG90by5qcGciLCJnaXZlbl9uYW1lIjoiQW5kcsOpIiwiZmFtaWx5X25hbWUiOiJXYWduZXIiLCJsb2NhbGUiOiJlbiIsImlhdCI6MTU1MTM2NjMyNywiZXhwIjoxNTUxMzY5OTI3LCJqdGkiOiI1YTFmYjk4MzZlYjFkM2UxYjdlNThmMzQ0MTgyMDBkMjU2MGY5NmIzIn0.BSL_c130VBfen_7jbLfYOyi4DmeBzmUq04yrAyjl1EuzcBBdrmeziXsV89SF_dBS8ZH4131C9UyUBrSoih__QXnZ6Qnr0vNEeTNu6OPdOfO_xAjuyukBJVNFQ7KtlSEE78G9INyRVjV3cv-z4AlcXXrH-yIT5l0QS_6NZHUgCrIRLZrq2SDgCNLKCqjQB_sjAAeDDd5i6UQia8YG8Q7ypsav2uWTZgCnROpa_3OH7UsndNNDsgmF43tolpD8FPW3yhHnF4r3xvDCRdqdvEORi2eUhPMhA-4ts33tcrzr8xhhlmIXAVzNfxQMPgHl2fRV_iUJ2Pz5UHUVmAw96l1i3w`
    user, err := interpretToken(token, true)
    assert.Assert(t, is.Nil(err))
    assert.Equal(t, user.Id, "101738586050672388163");
    assert.Equal(t, user.Name, "André Wagner")
    assert.Equal(t, user.Email, "andre.nho@gmail.com")
    assert.Equal(t, user.Picture, "https://lh5.googleusercontent.com/-3XJRf6gYTtI/AAAAAAAAAAI/AAAAAAAACFo/J5p1irPA4rE/s96-c/photo.jpg");
    assert.Equal(t, user.Expiration, time.Unix(1551369927, 0));
    assert.Equal(t, user.Issuer, "google");
}

// vim:ts=4:sts=4:sw=4:expandtab
