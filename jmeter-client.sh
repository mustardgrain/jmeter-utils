#!/bin/sh

if [ "`which jmeter`" = "" ] ; then
  echo "No jmeter script found. Please ensure JMeter is on PATH"
  exit 1
fi

if [ $# -lt 3 ] ; then
  echo "Usage: `basename $0` <JMeter port> <test file> <remote host> [<remote host> . . .]"
  exit 1
fi

port=$1
test_file=$2
shift 2

remote_hosts=

for remote_host in "$@" ; do
  if [ "$remote_hosts" != "" ] ; then
    remote_hosts="$remote_hosts,"
  fi

  remote_hosts=${remote_hosts}${remote_host}:${port}
done

rm -rf output $test_file.csv jmeter.log

jmeter \
  -n \
  -r \
  -t $test_file \
  -Jremote_hosts=$remote_hosts \
  -Jserver_port=$port \
  -Jclient.rmi.localport=$port \
  -Jserver.rmi.localport=$port \
  -l $test_file.csv \
  -e \
  -o output

zip -qr output.zip output

rm -rf output $test_file.csv jmeter.log
