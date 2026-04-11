#!/bin/bash

# Color codes
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

log() {
  local level="$1"
  shift
  local message="$*"

  case "$level" in
    INFO)
      echo -e "${BLUE}[INFO]${NC} - ${message}"
      ;;
    SUCCESS)
      echo -e "${GREEN}[SUCCESS]${NC} - ${message}"
      ;;
    WARN)
      echo -e "${YELLOW}[WARN]${NC} - ${message}"
      ;;
    ERROR)
      echo -e "${RED}[ERROR]${NC} - ${message}"
      ;;
    *)
      echo -e "[LOG] - ${message}"
      ;;
  esac
}

export -f log