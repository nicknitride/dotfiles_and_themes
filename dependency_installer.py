#!/usr/bin/python3
import subprocess, sys

command = sys.argv[1:]
# This passes the command line arguments written next to this python script when invoked

Method_1
subprocess.run(command[0], shell=True, executable="/usr/bin/bash")
# This assigns the first argument in the command argument array 
# i.e. ./script ls == /usr/bin/bash ls
