#!/bin/bash

#processing-java --force --sketch=$PWD --build=/Users/friedrichweise/repos/visualizer/ --present  --run
processing-java --sketch=$(cd "$(dirname "$0")" && pwd) --output=$(cd "$(dirname "$0")" && pwd)/output --force --run
