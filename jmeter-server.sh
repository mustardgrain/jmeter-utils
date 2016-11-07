#!/bin/sh

if [ "`which jmeter-server`" = "" ] ; then
  echo "No jmeter-server script found. Please ensure JMeter is on PATH"
  exit 1
fi

port=$1

if [ $# -lt 1 ] ; then
  echo "Usage: `basename $0` <JMeter port>"
  exit 1
fi

port=$1

rm -rf jmeter-server.log

jmeter-server \
  -Jremote_hosts=localhost:$port \
  -Jserver_port=$port \
  -Jclient.rmi.localport=$port \
  -Jserver.rmi.localport=$port

rm -rf jmeter-server.log
