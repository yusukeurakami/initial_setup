#!/bin/bash

# Source: https://askubuntu.com/a/937596
sudo() {
  [[ "${EUID}" == 0 ]] || set -- command sudo "${@}"
  "${@}"
}
