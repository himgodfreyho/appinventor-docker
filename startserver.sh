#!/bin/bash
set -e

cd /root/appinventor-sources/appinventor && dev_appserver.sh --port=8888 --address=0.0.0.0 appengine/build/war/