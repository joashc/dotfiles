#!/bin/bash
cpupower frequency-set -g ondemand
systemctl restart bluetooth
