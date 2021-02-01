#!/bin/sh

cd /usr/src/app
rake inet:download 
rake tiles
rake style
rake host