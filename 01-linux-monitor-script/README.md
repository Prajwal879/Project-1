# System Monitor Script

A lightweight Bash script to monitor CPU, memory, and disk usage on Linux.

## Features
- CPU, memory, disk, and top process reporting
- Alert thresholds (configurable)
- Watch mode (live refresh)
- Log mode (saves output to file)

## Usage

```bash
chmod +x monitor.sh

# One-time report
./monitor.sh

# Live watch (refresh every 5s)
./monitor.sh --watch 5

# Save report to monitor.log
./monitor.sh --log
```

## Alerts (edit script to change thresholds)
| Metric | Default Threshold |
|--------|------------------|
| CPU    | 80%              |
| Memory | 80%              |
| Disk   | 90%              |

## Requirements
- Linux (bash, top, free, df, ps)
- No external dependencies
