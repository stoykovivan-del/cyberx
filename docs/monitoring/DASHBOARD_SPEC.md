# Monitoring Dashboard Specification

## Overview
This document defines the Grafana dashboard for CyberX system monitoring, displaying key metrics and KPIs for operations team visibility.

## Dashboard Structure

### Main Dashboard: "CyberX System Overview"

#### Row 1: System Health (Top-level status)

| Panel | Type | Metrics |
|-------|------|---------|
| System Status | Stat | Overall health (healthy/degraded/down) |
| Uptime | Gauge | System uptime percentage |
| Active Services | Stat | Count of running services |

#### Row 2: Request Metrics

| Panel | Type | Metrics |
|-------|------|---------|
| Requests per Second | Time Series | rps by endpoint |
| Response Time (p50) | Time Series | Median response time |
| Response Time (p95) | Time Series | 95th percentile response time |
| Error Rate | Time Series | Percentage of 5xx errors |

#### Row 3: Resource Utilization

| Panel | Type | Metrics |
|-------|------|---------|
| CPU Usage | Time Series | % CPU by service |
| Memory Usage | Time Series | % RAM by service |
| Disk I/O | Time Series | Read/write operations |
| Network Traffic | Time Series | Bytes in/out |

#### Row 4: Application Metrics

| Panel | Type | Metrics |
|-------|------|---------|
| Active Users | Time Series | Unique users in last hour |
| API Call Volume | Time Series | Total API calls |
| Cache Hit Rate | Time Series | Cache efficiency % |
| Queue Depth | Time Series | Pending messages |

#### Row 5: Error & Alert Status

| Panel | Type | Metrics |
|-------|------|---------|
| Error Count (Last 24h) | Time Series | Errors by severity |
| Active Alerts | Table | Current alert details |
| Failed Jobs | Stat | Count of failed background jobs |

## Data Source Configuration

```yaml
# grafana/datasources.yaml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
```

## Panel Query Examples

### Response Time (p95)
```promql
histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket{service=~".*"}[5m])) by (le, service))
```

### Error Rate
```promql
sum(rate(http_requests_total{service=~".*",status=~"5.."}[5m])) by (service) / sum(rate(http_requests_total{service=~".*"}[5m])) by (service) * 100
```

### CPU Usage
```promql
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

## Alerting Integration

Each panel should trigger alerts based on thresholds:
- Error rate > 5% for 5 minutes
- Response time p95 > 2s for 5 minutes
- CPU > 80% for 10 minutes
- Memory > 85% for 10 minutes

## Refresh & Time Range

- Auto-refresh: 30 seconds
- Default time range: Last 6 hours
- Allowable ranges: 1h, 6h, 24h, 7d, 30d

## Dashboard Variables

| Variable | Query | Description |
|----------|-------|-------------|
| $service | label_values(service) | Service selector |
| $environment | label_values(environment) | Environment selector |

## JSON Export

Export dashboard as JSON for version control and import to Grafana:

```bash
curl -s -u admin:admin http://localhost:3000/api/dashboards/uid/cyberx-overview | jq '.dashboard' > cyberx-overview.json
```

## References

- Parent task: [CYB-44](/CYB/issues/CYB-44)
- Related: [CYB-46 Structured Logging](/CYB/issues/CYB-46), alerting rules, Prometheus configuration