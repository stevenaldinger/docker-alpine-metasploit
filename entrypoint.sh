#!/bin/bash

set -e

if [ -f /usr/bin/custom_entrypoint ]; then
  chmod a+x /usr/bin/custom_entrypoint
  custom_entrypoint
else
  cd /metasploit-framework && bundle install --without ''
  /metasploit-framework/msfconsole --help
fi
