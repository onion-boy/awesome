#!/bin/sh

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run "xrandr --output Virtual-1 --mode 1920x1080"
run "picom -b"