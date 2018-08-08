#!/bin/sh
LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH \
  exec $HOME/pypy/bin/$(basename $0) $@
