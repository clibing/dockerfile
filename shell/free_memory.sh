#!/bin/bash

free -m
echo "will Free memory...."
echo 3 >/proc/sys/vm/drop_caches
free -m
