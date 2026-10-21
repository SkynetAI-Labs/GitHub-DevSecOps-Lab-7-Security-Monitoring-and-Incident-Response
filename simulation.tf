resource "aws_iam_role" "simulation" {
  name                 = "${local.prefix}-simulation"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = data.aws_iam_role.operator.arn }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "simulation" {
  name = "deny-read-only-simulation"
  role = aws_iam_role.simulation.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "DenyInstanceListing"
      Effect   = "Deny"
      Action   = "ec2:DescribeInstances"
      Resource = "*"
    }]
  })
}

output "simulation_role_arn" {
  value = aws_iam_role.simulation.arn
}

output "trail_name" {
  value = aws_cloudtrail.lab.name
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.trail.name
}

output "alarm_name" {
  value = aws_cloudwatch_metric_alarm.denied.alarm_name
}

output "alert_queue_url" {
  value = aws_sqs_queue.alerts.id
}

output "log_bucket_name" {
  value = aws_s3_bucket.logs.id
}
