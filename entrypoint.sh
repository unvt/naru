#!/bin/sh

cd /usr/src/app
rake inet:download 
rake inet:mbgljs
rake js
rake inet:sprite
rake inet:fonts
rake tiles
rake style
rake host