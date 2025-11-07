#!/bin/bash
# Copyright (c) 2024-2025 david921518@qq.com
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
set +e
echo -e "\n\033[32m\t*********Welcome to QKD-DEV!*********\033[0m\n"
echo -e "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "\n"

function check_shell_environment() {
  case $(uname -s) in 
    Linux)
          shell_result=$(/bin/sh -c 'echo ${BASH_VERSION}')
          if [ -n "${shell_result}" ]; then
            echo -e "\033[32mSystem shell: bash ${shell_result}\033[0m"
          else
            echo -e "\033[33m Your system shell isn't bash, we recommend you to use bash, because some commands may not be supported in other shells, such as pushd and shopt are not supported in dash. \033[0m"
          fi
          ;;
    Darwin)
          echo -e "\033[31m[QKD-DEV ERROR] Darwin system is not supported yet\033[0m"
          ;;
    *)
          echo -e "\033[31m[QKD-DEV ERROR] Unsupported this system: $(uname -s)\033[0m"
          exit 1
  esac
}

check_shell_environment 

function usage() {
  echo -e "\n$(basename "${0}") <CONTAINER> <ACTION> [ARGUMENTS]"
  echo -e "  build <file>    Build <CONTAINER> image with dockerfile <file>"
  echo -e "  load <file>     Load <CONTAINER> from <file>"
  echo -e "  save <file>     Save <CONTAINER> to <file>"
  echo -e "  run [cmd]       Run [cmd] in <CONTAINER>"
  exit "${1:-0}"
}

if [ "${#}" -lt 2 ]; then
  usage
fi

CONTAINER="${1}"; shift
ACTION="${1}"; shift

function validate_workdir() {
  case "$(pwd)" in
    "${1}"*)
        ;;
    *)
        echo "${0}: Cannot execute outside ${1}/*"
        exit 1
  esac
}

function docker_build() {
  docker build --tag "${CONTAINER}" --file "${1}" "$(dirname "${1}")"
  docker system prune -f
}

function docker_load() {
  docker load --input "${1}"
}

function docker_save() {
  docker save "${CONTAINER}" | gzip > "$(pwd)/${CONTAINER}.tar.gz"
}

function docker_run() {
  echo "${0}: RUN ${CONTAINER}"
  echo "${0}: CMD ${@}"
  WORK_DIR=$(pwd)
  WORK_DIR="$(dirname "${WORK_DIR}")"
  if [ "${WORK_DIR}" == "/" ]; then
    WORK_DIR="$(pwd)"
  fi

  docker run --name ${USER}-build-qkd-qpp \
        -it -d --user "$(id -u):$(id -g)" \
        --volume "/etc/passwd:/etc/passwd" -v /etc/shadow:/etc/shadow:ro  -v /etc/group:/etc/group:ro \
        --volume "${HOME}:${HOME}" \
        --volume /fastbuild:/fastbuild \
        --volume /build:/build \
        --volume "${WORK_DIR}:${WORK_DIR}" \
        --workdir "$(pwd)" \
        --dns=8.8.8.8 --dns=8.8.4.4 \
        "${CONTAINER}" "${@}"
}

case "${ACTION}" in
  build|load|run|save)
      eval "docker_${ACTION}" "${@}"
      ;;
  *)
      usage
      ;;
esac
