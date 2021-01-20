#!/usr/bin/env bash
# vim: ft=bash:sw=4:et

# Author:
#     Copyright 2020, 2021 Todd A. Jacobs
# License:
# 	GPLv3
# Purpose:
# 	Simplify installation of a local instance of Concourse-CI and the fly
#	binary under macOS.

: ${BROWSER_DELAY_SECS:=5}
: ${CFG_YAML:='https://concourse-ci.org/docker-compose.yml'}
: ${CONCOURSE_DIR:="$HOME/Documents/docker/concourse"}
: ${CONCOURSE_HOST:='localhost'}
: ${CONCOURSE_PORT:='8080'}

CONCOURSE_LOCAL_URL="http://$CONCOURSE_HOST:$CONCOURSE_PORT"
CONCOURSE_TCP_SOCKET="/dev/tcp/$CONCOURSE_HOST/$CONCOURSE_PORT"

# install dependencies
brew install wget
brew install --cask virtualbox{,-extension-pack} docker fly

# work around unsigned golang app without GUI interaction
xattr -dr com.apple.quarantine "$(brew --prefix)/bin/fly"

# retrieve vendor's docker-compose.yml file
mkdir -p "$CONCOURSE_DIR" &&
    cd "$CONCOURSE_DIR" &&
    wget -N "$CFG_YAML"

print_to_stderr () {
    echo >&2
    echo "$@" >&2
}

# XXX: don't print_to_stderr since wget adds trailing space
echo 'Launching Docker Desktop ...' >&2
open /Applications/Docker.app
until docker ps > /dev/null 2>&1; do
    sleep 1
done

print_to_stderr 'Pulling images ...'
docker-compose pull

print_to_stderr 'Starting containers ...'
docker-compose up -d

print_to_stderr 'Waiting for active port ...'
until true &>/dev/null <"$CONCOURSE_TCP_SOCKET"; do
    sleep 1
done

print_to_stderr \
    "Launching default browser in $BROWSER_DELAY_SECS seconds ..."
sleep "$BROWSER_DELAY_SECS"
open "$CONCOURSE_LOCAL_URL"
