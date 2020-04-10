#!/bin/bash -x

exec >> ./$(basename $0%.*)_`LANG=c date +%Y%m%d_%H%M`.log 2>&1
