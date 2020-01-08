#! /bin/bash
## to build scanner/parser
bison -d -v sde1.y
flex sde1.in
gcc sde1.c -lfl -Wall -o sde1
