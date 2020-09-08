#!/bin/bash
BASEDIR=$(dirname "$0")
kill -9 `cat $BASEDIR/n8n.pid`
rm $BASEDIR/n8n.pid
