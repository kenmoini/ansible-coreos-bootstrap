#!/bin/sh

exec LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH \
  $HOME/pypy/bin/$(basename $0) $@
