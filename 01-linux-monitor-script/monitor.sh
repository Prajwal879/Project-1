#!/bin/bash

ALERT_CPU=80
ALERT_MEM=80
ALERT_DISK=90
LOG_FILE="monitor.log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

get_cpu() {
  cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
  echo "${cpu:-0}"
}

get_mem() {
  read -r total used <<< $(free -m | awk '/Mem:/{print $2, $3}')
  echo $(( used * 100 / total ))
}

get_disk() {
  df -h / | awk 'NR==2{print $5}' | tr -d '%'
}

check_alerts() {
  cpu=$(get_cpu)
  mem=$(get_mem)
  disk=$(get_disk)

  [ "${cpu%.*}" -ge "$ALERT_CPU" ]  && log "ALERT: CPU at ${cpu}%"
  [ "$mem"  -ge "$ALERT_MEM" ]       && log "ALERT: Memory at ${mem}%"
  [ "$disk" -ge "$ALERT_DISK" ]      && log "ALERT: Disk at ${disk}%"
}

print_report() {
  echo "=============================="
  echo "     SYSTEM MONITOR REPORT    "
  echo "=============================="
  echo "Host    : $(hostname)"
  echo "Date    : $(date)"
  echo "Uptime  : $(uptime -p)"
  echo ""
  echo "--- CPU ---"
  echo "Usage   : $(get_cpu)%"
  echo ""
  echo "--- Memory ---"
  free -h | awk 'NR<=2'
  echo ""
  echo "--- Disk ---"
  df -h | grep -E '^/dev|Filesystem'
  echo ""
  echo "--- Top 5 Processes (CPU) ---"
  ps aux --sort=-%cpu | awk 'NR==1 || NR<=6' | awk '{printf "%-10s %-6s %-6s %s\n",$1,$3,$4,$11}'
  echo "=============================="
}

main() {
  case "${1:-}" in
    --watch)
      interval="${2:-5}"
      log "Watching every ${interval}s (Ctrl+C to stop)"
      while true; do
        print_report
        check_alerts
        sleep "$interval"
        clear
      done
      ;;
    --log)
      print_report | tee -a "$LOG_FILE"
      check_alerts
      log "Report saved to $LOG_FILE"
      ;;
    *)
      print_report
      check_alerts
      ;;
  esac
}

main "$@"
