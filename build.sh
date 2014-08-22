#!/usr/bin/env sh

# RPC Websocket
# Written by Erik Poupaert, Cambodia
# (c) 2014
# Licensed under the LGPL

## add web support

browserify lib/rpc-socket.js -o browser-support/bundle.js
uglifyjs browser-support/bundle.js -o browser-support/bundle.min.js

## build API documentation

jsdoc2md lib/rpc-socket.js > doc/api/rpc-socket.md
jsdoc2md lib/rpc-server.js > doc/api/rpc-server.md

## create first draft of README.md

for f in $(ls doc/readme); do
        cat doc/readme/$f >> README.draft.1.md
done

## add external files

markdown-pp.py README.draft.1.md README.draft.2.md
rm -f README.draft.1.md

## replace ../index.js and ../../index.js by rpc-websocket

sed -e 's/\.\.\/\.\.\/index.js/rpc-websocket/' \
        -e 's/\.\.\/index.js/rpc-websocket/' README.draft.2.md > \
       README.md
rm -f README.draft.2.md
