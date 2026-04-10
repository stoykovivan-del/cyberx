# Structured Application Logging Configuration

## Overview
This document defines the structured logging approach for all CyberX systems, implementing severity levels and JSON-formatted output for machine parsing.

## Log Format

All application logs MUST use JSON format with the following structure:

```json
{
  "timestamp": "2026-04-08T00:00:00.000Z",
  "level": "INFO",
  "message": "User logged in successfully",
  "service": "auth-service",
  "environment": "production",
  "trace_id": "abc123",
  "span_id": "def456",
  "user_id": "user-789",
  "metadata": {
    "ip_address": "192.168.1.1",
    "user_agent": "Mozilla/5.0..."
  }
}
```

## Severity Levels

| Level | Usage | Example |
|-------|-------|---------|
| ERROR | Application errors requiring immediate attention | Uncaught exceptions, service failures |
| WARN | Abnormal conditions that need attention | Rate limits, degraded performance |
| INFO | Normal operational events | User actions, state transitions |
| DEBUG | Detailed diagnostic information | Variable values, flow execution |

## Required Fields

- `timestamp`: ISO 8601 format with milliseconds
- `level`: Uppercase severity (ERROR, WARN, INFO, DEBUG)
- `message`: Human-readable log message
- `service`: Identifier of the originating service

## Optional Fields (context-dependent)

- `trace_id`: Distributed tracing ID
- `span_id`: Current span identifier
- `request_id`: HTTP request ID
- `user_id`: Authenticated user identifier
- `metadata`: Additional context object

## Implementation Guidelines

### 1. Environment Variables

```bash
LOG_LEVEL=info              # Minimum level to output
LOG_FORMAT=json            # json or plain
LOG_OUTPUT=stdout          # stdout, stderr, or file path
LOG_INCLUDE_TRACE=true     # Include trace context
```

### 2. Code Implementation Pattern

For Node.js/TypeScript:
```typescript
interface LogEntry {
  timestamp: string;
  level: 'ERROR' | 'WARN' | 'INFO' | 'DEBUG';
  message: string;
  service: string;
  trace_id?: string;
  span_id?: string;
  metadata?: Record<string, unknown>;
}

function log(level: LogEntry['level'], message: string, metadata?: Record<string, unknown>): void {
  const entry: LogEntry = {
    timestamp: new Date().toISOString(),
    level,
    message,
    service: process.env.SERVICE_NAME || 'unknown',
    ...(process.env.TRACE_ID && { trace_id: process.env.TRACE_ID }),
    ...(metadata && { metadata })
  };
  
  if (shouldLog(level)) {
    console.log(JSON.stringify(entry));
  }
}
```

### 3. Library Recommendations

- Node.js: `pino` - Fast JSON logger with low overhead
- Python: `structlog` - Structured logging for Python
- Go: `zap` - Fast, structured logging in Go

## Integration with Monitoring

- Logs flow to centralized logging system (Elasticsearch/Loki)
- ERROR and WARN levels trigger alerts
- Log aggregation enables:
  - Error rate dashboards
  - Request tracing correlation
  - Performance anomaly detection

## Retention Policy

| Environment | Retention | Use Case |
|-------------|-----------|----------|
| Production | 30 days | Debugging, analysis |
| Staging | 7 days | Testing, validation |
| Development | 1 day | Local debugging |

## References

- Parent task: [CYB-44](/CYB/issues/CYB-44)
- Related: Prometheus metrics, alerting rules, health endpoints