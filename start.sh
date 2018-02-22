#!/bin/bash
processing-java --sketch=$(cd "$(dirname "$0")" && pwd) --output=$(cd "$(dirname "$0")" && pwd)/output --force --run
