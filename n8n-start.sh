#!/bin/bash
BASEDIR=$(dirname "$0")
nohup $BASEDIR/n8n.js >> $BASEDIR/n8n.log 2>&1 &
echo $! > $BASEDIR/n8n.pid
