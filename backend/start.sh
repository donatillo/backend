#!/bin/sh

python initialization.py
nginx -g 'pid /tmp/nginx.pid; error_log /dev/stdout debug;'
uwsgi --ini backend.ini
