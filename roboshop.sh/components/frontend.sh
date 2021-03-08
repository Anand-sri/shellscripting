#!/bin/bash

INFO () {
  echo -e "[\e[1;34mINFO\e[0m] [\e[1;35mFRONTEND\e[0m] [\e[1;36m$(date "+%F +%T")\e[0m] $1"
}

SUCC () {
  echo -e "[\e[1;32mSUCC\e[0m] [\e[1;35mFRONTEND\e[0m] [\e[1;36m$(date "+%F +%T")\e[0m] $1"
}

FAIL () {
  echo -e "[\e[1;32mFAIL\e[0m] [\e[1;35mFRONTEND\e[0m] [\e[1;36m$(date "+%F +%T")\e[0m] $1"
}

INFO "setup frontend component"
INFO "installing nginx"
SUCC "installed nginx"
FAIL "installed nginx"

