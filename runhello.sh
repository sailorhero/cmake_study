#!/bin/sh

#current path
filepath=$(cd "$(dirname "$0")"; pwd)
echo $filepath

export LD_LIBRARY_PATH=${filepath}/../lib;${LD_LIBRARY_PATH}

${filepath}/hello
