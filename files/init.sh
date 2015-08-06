#!/bin/bash
BANNER=<<'EOF'
     (       (                )      (                      
     )\ )    )\ )  *   )   ( /(      )\ )                   
    (()/((  (()/(` )  /(   )\())   )(()/((          ) (     
     /(_))\  /(_))( )(_)) ((_)\ ( /( /(_))(   (  ( /( )\ )  
    (_))((_)(_)) (_(_())   _((_))(_)|_))(()\  )\ )\()|()/(  
    | _ \ __/ __||_   _|  | || ((_)_| _ \((_)((_|(_)\ )(_)) 
    |   / _|\__ \  | |    | __ / _` |  _/ '_/ _ \ \ /| || | 
    |_|_\___|___/  |_|    |_||_\__,_|_| |_| \___/_\_\ \_, | 
                                                      |__/  
EOF
ROOT_PATH="/opt/rest_haproxy"
PID_PATH="$ROOT_PATH/rest_haproxy.pid"
LOG_PATH="/dev/null"

is_running(){
  if [[ -e $PID_PATH ]]; then
    return true
  else
    return false
  fi
}

start() {
  if is_running; then
    echo "Service already running"
    return 0
  else
    echo $BANNER 
    /opt/rest_haproxy/./rest_haproxy > $LOG_PATH &
    echo $? > /opt/rest_haproxy.pid
    echo "REST HaProxy Started.\n"
    echo "PID: $?\n"
    return 0
  fi
}

stop() {
  if is_running; then
    "Stopping REST HaProxy..."
    kill -9 $(cat $PID_PATH)
    rm $PID_PATH
  else
    echo "REST HaProxy does not appear to be running"
    return 0
  fi
}

restart() {
  stop
  start
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    restart
    ;;
  *)
    echo "Options: start|stop|restart"
    ;;
esac
exit $@
