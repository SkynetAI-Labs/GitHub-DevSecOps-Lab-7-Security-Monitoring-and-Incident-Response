# Repository Security Audit — Lab 07

**Review date:** 24 October 2026  
**Reviewed source commit:** [`1247aa388b5fef06d1d2040be8323696b0309f89`](https://github.com/SkynetAI-Labs/lab-07-security-monitoring-response/tree/1247aa388b5fef06d1d2040be8323696b0309f89)  
**Scope:** Public repository configuration, documentation, retained evidence and available workflow results. This is a repository audit, not a fresh live-environment assessment or penetration test.

## Outcome
Formatting, backend-disabled initialization and Terraform validation passed in [run 40133519840](https://github.com/SkynetAI-Labs/lab-07-security-monitoring-response/actions/runs/40133519840), for `1247aa388b5fef06d1d2040be8323696b0309f89`. Checkov 3.3.30 reported **54 passed, 10 failed, 0 skipped**, so the workflow failed.

## Evidence checked
- Terraform logging, alerts and simulation configuration, CI, incident report and public sanitized results summary.
- Historical evidence records a denied read-only request, correlated CloudTrail request ID, CloudWatch alarm and SNS-to-SQS receipt. The recorded request-to-alarm interval was 48.926 seconds.
- The retained record reports 19 resources created and destroyed. Public summary consistency was checked; private raw AWS responses were not independently examined.
- CloudTrail is regional and excludes global-service events; this is not account-wide monitoring.
- CloudWatch retention is one day. S3 current-object expiration is seven days and noncurrent-version expiration one day; these periods are not a guaranteed total deletion deadline.
- Missing metric data is treated as non-breaching, so an OK alarm alone does not prove pipeline health.

## Open scan findings
SNS encryption; CloudWatch KMS and retention; CloudTrail KMS, SNS delivery notification and multi-region coverage; S3 event notifications, access logging, KMS and replication. All ten remain visible and unsuppressed.

## Recommendations
1. **Priority 1 — Add pipeline-health monitoring** for log delivery failures and missing telemetry, with a separate health signal from the denied-call alarm.
2. **Priority 1 before broader use — Define regional/global event coverage and retention requirements**, then implement and test the required scope.
3. **Priority 2 — Test notification failure/recovery**, define redrive/dead-letter behavior where needed and document an operator response procedure.
4. **Priority 2 — Resolve or formally own the ten scan findings**, including correct service permissions if customer-managed keys are introduced.
5. **Priority 2 — Validate CloudTrail digest chains cryptographically**; digest delivery alone is not chain verification.
6. **Priority 2 — Pin direct CI actions to verified SHAs** and preserve dated evidence outside expiring logs.

The matching Lab 07 banner and historical/live evidence clarifications were added earlier in this audit cycle. No automated containment or fresh incident simulation was performed.

## Banner and evidence integrity

The README links an existing `skynet-lab-07.png` banner and the asset is present. No replacement was needed in this portfolio-wide pass. Historical evidence was preserved. Recommendations above remain open unless explicitly described as completed.

## References

- [GitHub Actions security guidance](https://docs.github.com/en/actions/reference/security/secure-use)
- [AWS S3 transport-encryption guidance](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingEncryptionInTransit.html)
- [Kubernetes NetworkPolicy semantics](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

