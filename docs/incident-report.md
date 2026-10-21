# Lab 7 — Simulated Denied API Incident

## Classification
Authorised security-control test, not a confirmed compromise.

## Timeline (UTC)
- 2026-10-21 23:29:12.466353: test request started.
- 2026-10-21 23:29:12: CloudTrail recorded DescribeInstances.
- 2026-10-21 23:30:01.392: alarm changed from OK to ALARM.
- 2026-10-21 23:30:01.443: CloudWatch reported successful SNS action.
- The corresponding ALARM notification was retrieved from SQS.
  Retrieval time is recorded in the private queue receipt.

## Investigation
- Region: eu-north-1.
- Service: ec2.amazonaws.com.
- Operation: DescribeInstances.
- Role: lab7-security-simulation.
- Session: lab7-denied-api-test.
- Request ID: 5fe1e4c2-5f16-4af3-ae69-4f97d98f3ad3.
- Event ID: e0f90d03-19b3-4878-991e-c33884f2f28a.
- CloudTrail error: Client.UnauthorizedOperation.
- Exact request ID, role and session matched the simulation.
- CloudTrail marked the request read-only.
- Observed request-start-to-ALARM time: 48.926 seconds.
- This is one observation, not a latency guarantee.
- The general denied-API alarm is not scoped to this request.
  Its timing is consistent with the test; other denied calls could
  also contribute to the same metric.

## Response
The test role's explicit deny prevented this read-only listing.
This was a preventive control configured before the test, not
containment triggered by the alert.

No destructive API request was attempted. Temporary credentials
were held in memory and were not printed or saved by the script.
Their requested session duration was 900 seconds.

Private evidence was backed up and downloaded. Nine S3 object versions were hash-verified and deleted. Terraform destroyed all 19 resources. Independent AWS API checks confirmed the lab resources were absent.
No automated containment or session revocation has been demonstrated.

## Verified Monitoring Results
- Exact denied request found in CloudWatch Logs.
- Alarm changed from OK to ALARM.
- CloudWatch reported successful SNS action.
- Matching alarm-state notification retrieved from SQS.
- Trail status reported S3, CloudWatch Logs and digest delivery
  without reported delivery errors.

## Limitations
- Single-region lab, not production monitoring.
- Global service events, data events, KMS management events and
  RDS Data API management events were outside the configured scope.
- One general denied-API detection rule.
- No email or human acknowledgement delivery test.
- No cryptographic digest-chain validation.
- Missing metric data is treated as non-breaching, so an OK state
  alone does not prove the logging pipeline is healthy.
- No broad account-compromise investigation was performed.
- Static security scanning remains pending. Cleanup verification completed.
