#!/bin/bash

set -e
set -u

while clipnotify; do
    echo -n "" | xclip -i -selection primary
    echo -n "" | xclip -i -selection secondary
done
