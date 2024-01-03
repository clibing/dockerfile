#########################################################################
# File Name: ss.sh
# Author: clibing
# mail: wmsjhappy@@gmail.com
# Created Time: 五 12/15 14:45:56 2023
#########################################################################
#!/bin/bash

name="admin 1234"

c=${name:1,3}

b=$(expr substr $name 1 3)

echo "$b"
echo "$c"
