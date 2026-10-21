# Security Findings

## Verified Static Scan
- Scanner: Checkov 3.3.30.
- Scope: Terraform source; private evidence excluded.
- Result: 54 passed, 10 failed, 0 skipped.
- Findings remain open and unsuppressed.
- Static results do not establish production compliance.
- The deployed environment was destroyed and independently checked.

## Open Findings

| Check | Resource | Finding and lab limitation |
|---|---|---|
| CKV_AWS_26 | SNS topic | Topic encryption at rest was not configured. Adding customer-managed KMS encryption requires appropriate alarm-publishing key permissions. |
| CKV_AWS_338 | CloudWatch log group | Retention was one day, below the scanner's one-year requirement. This was a temporary lab, not a production retention policy. |
| CKV_AWS_158 | CloudWatch log group | No customer-managed KMS key was configured. This finding does not mean CloudWatch Logs lacks default encryption at rest. |
| CKV_AWS_252 | CloudTrail | No SNS topic was configured for CloudTrail log-file delivery notifications. The separate CloudWatch alarm notification route was verified through SNS and SQS. |
| CKV_AWS_35 | CloudTrail | No customer-managed KMS key was configured for trail logs. S3 AES256 encryption was configured. |
| CKV_AWS_67 | CloudTrail | Trail covered eu-north-1 only. Multi-region and global-service monitoring were outside this lab's scope. |
| CKV2_AWS_62 | S3 bucket | S3 event notifications were not configured. |
| CKV_AWS_18 | S3 bucket | S3 server access logging was not configured. |
| CKV_AWS_145 | S3 bucket | Default encryption used AES256 rather than a customer-managed KMS key. |
| CKV_AWS_144 | S3 bucket | Cross-region replication was not configured. |

## Additional Limitations
- SQS used SQS-managed encryption, not a customer-managed KMS key.
  The scanner's passing CKV2_AWS_73 result is not evidence of a
  customer-managed key.
- Missing metric data was treated as non-breaching; an OK alarm
  alone does not establish pipeline health.
- Digest delivery was reported; cryptographic chain validation
  was not performed.
- One real denied read-only request and one corresponding ALARM
  notification were verified.
- No automated containment, destructive simulation or production
  incident-response capability was demonstrated.

## CI Status
GitHub Actions has not yet been configured or executed.
