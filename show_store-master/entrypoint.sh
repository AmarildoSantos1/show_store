#!/bin/bash
set -e

rm -f /articles-api/tmp/pids/server.pid

exec "$@"