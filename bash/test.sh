#!/bin/bash

FILE=/tmp/baptist/test_data

log() {
  echo "`date +"%m/%d/%Y %T"` $1"
}

check_file() {
  grep -q "Daniel" $FILE
  local result=$?
  log "Checked file; result=$result"
  return $result
}

test() {
  check_file
  local result=$?
  if [ $result = 0 ]
  then
    log "Test complete; result=\"Contains Daniel\""
  else
    log "Test complete; result=\"Does not contain Daniel\""
  fi
}

rm $FILE

touch $FILE
test

echo "Daniel" > $FILE
test
