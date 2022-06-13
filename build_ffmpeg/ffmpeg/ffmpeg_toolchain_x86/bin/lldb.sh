#!/bin/bash
CURDIR=$(cd $(dirname $0) && pwd)
PYTHONHOME="$CURDIR/../python3" "$CURDIR/lldb" "$@"
