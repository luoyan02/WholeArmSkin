#!/usr/bin/env bash

set -ex

cd "${HOME}/workspace"

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  cat ./build/ada_description/Testing/Temporary/LastTest.log
  cat ./build/ada_description/Testing/Temporary/LastTestsFailed.log
fi
