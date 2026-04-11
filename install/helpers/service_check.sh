#!/bin/bash

service_exists() {
  systemctl status "$1" &> /dev/null
}

export -f service_exists