#!/bin/bash

set -e

if [ -f /usr/bin/custom_entrypoint ]; then
  chmod a+x /usr/bin/custom_entrypoint
  custom_entrypoint
else
  msfcli -h
fi
