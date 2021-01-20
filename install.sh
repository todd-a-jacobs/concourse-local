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

brew install wget
brew install --cask virtualbox{,-extension-pack} docker fly

# unsigned app; wontfix per Pivotal developers
xattr -dr com.apple.quarantine "$(brew --prefix)/bin/fly"

concourse_dir="$HOME/Documents/docker/concourse"
    mkdir -p "$concourse_dir" &&
    cd "$concourse_dir" &&
    wget -N 'https://concourse-ci.org/docker-compose.yml'

print_to_stderr () {
    echo >&2
    echo "$@" >&2
}

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
until true &>/dev/null </dev/tcp/127.0.0.1/8080; do
    sleep 1
done

print_to_stderr 'Launching default browser ...'
sleep 5
open http://localhost:8080
