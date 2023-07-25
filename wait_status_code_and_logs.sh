#!/bin/bash

set +e;

MAIN_MSGCOLOR=`tput setaf 27`
MSGCOLOR=`tput setaf 3`
GREEN_COLOR=`tput setaf 155`
WHITE_COLOR=`tput setaf 055`
YELLOW_COLOR=`tput setaf 208`
NOCOLOR=`tput sgr0`
ERRCOLOR=`tput setaf 198`

count=1
sleep_seconds_passed=0
waitsec=5
sleep_timeout_seconds=30
try_msg="try again in $waitsec seconds"
#Trim the command parameter
command=$(echo "$1" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
if [ $# -lt 1 ] || ! [ -n "$command" ]; then
  echo "Usage: $0 <command> <match_in_logs> => Pass not empty command"
  exit 1
fi

while true; do

logs=$(eval $command)
status_code=$?

if [[ "$status_code" -eq 0 ]]; then
  if ! [[ -n $2 ]]; then
    echo "${GREEN_COLOR}========    OK, exit code [${WHITE_COLOR}$status_code${GREEN_COLOR}]     ========${NOCOLOR} [$0]"
    break
  elif [[ $logs == *"$2"* ]]; then
    echo "${GREEN_COLOR}========    OK, exit code [${WHITE_COLOR}$status_code${GREEN_COLOR}], match found [${YELLOW_COLOR}$2${GREEN_COLOR}] in logs    ========${NOCOLOR} [$0]"
    break
  else
    main_msg="${MAIN_MSGCOLOR}=======no match found [${NOCOLOR}$2${MAIN_MSGCOLOR}] in logs, status code [${NOCOLOR}$status_code${MAIN_MSGCOLOR}], $try_msg ================${NOCOLOR} [$0]"
    printf "${main_msg}\n"
  fi
else
  echo "${ERRCOLOR}ERROR${NOCOLOR}, exit code $status_code, $try_msg"
fi
echo "${MSGCOLOR}count [$count], $sleep_seconds_passed/$sleep_timeout_seconds sleep_seconds_passed/sleep_timeout_seconds${NOCOLOR}"
count=$((count + 1))
if [[ $sleep_seconds_passed -ge $sleep_timeout_seconds ]]; then
 echo "${ERRCOLOR}exit on timeout${NOCOLOR}, $sleep_seconds_passed sleep seconds have passed, status code $status_code, [$0]"
 set -e
 exit 1
fi
sleep_seconds_passed=$((sleep_seconds_passed + waitsec))

sleep $waitsec
done
