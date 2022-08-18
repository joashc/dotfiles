#!/bin/bash
output=$(bash -c "cat $2 | $(cat $1 | sed -e 's|\(.*\)|"\1"|' | sed -z 's|\n| |g' | sed 's|^|ramda |')")
echo $output | jq -C
echo $output | xclip -selection clipboard
