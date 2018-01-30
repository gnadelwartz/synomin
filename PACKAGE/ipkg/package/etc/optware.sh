#!/bin/sh

# Optware setup

case $1 in
start)
     for i in /opt/etc/init.d/S??* ;do

          # Ignore dangling symlinks (if any).
          [ ! -f "$i" ] && continue

          case "$i" in
               *.sh)
               # Source shell script for speed.
               (
                    trap - INT QUIT TSTP
                    set start
                    . $i
               )
          ;;
               *)
               # No sh extension, so fork subprocess.
               $i start
          ;;
          esac
     done
;;
stop)
     for i in /opt/etc/init.d/S??* ;do

          # Ignore dangling symlinks (if any).
          [ ! -f "$i" ] && continue

          case "$i" in
               *.sh)
               # Source shell script for speed.
               (
                    trap - INT QUIT TSTP
                    set stop
                    . $i
               )
          ;;
               *)
               # No sh extension, so fork subprocess.
               $i stop
          ;;
          esac
     done
;;

*)
     echo "Usage: $0 [start|stop]"
;;
esac