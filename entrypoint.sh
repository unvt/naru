#!/bin/sh

cd /usr/src/app
rake inet:download 
rake inet:mbgljs
rake inet:sprite
rake inet:fonts
rake tiles
rake style
rake host