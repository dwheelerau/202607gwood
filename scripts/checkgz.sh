#!/bin/bash

if gzip -t $1; then
	echo $1 ' ok'
else
	echo $1 ' corrupt'
	#rm -f $1
fi
