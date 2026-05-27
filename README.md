# DevOps Utilities

A collection of shell scripts for DevOps engineers.

## Scripts

| Script | Description |
|--------|-------------|
| `scripts/log_analyzer.sh` | Analyze nginx access logs — top IPs, URLs, status codes |

## Usage

```bash
chmod +x scripts/log_analyzer.sh
./scripts/log_analyzer.sh logs/access.log
```

## Requirements

- bash 4+
- Standard Unix tools: awk, grep, sort, uniq, wc
