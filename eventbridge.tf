resource "aws_cloudwatch_event_rule" "myruler" {
  name        = "capture-aws-sign-in"
  description = "Capture each AWS Console Sign In"

  event_pattern = <<EOF
{
  "source": ["aws.s3"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["s3.amazonaws.com"],
    "eventName": ["ListObjects", "ListObjectVersions", "PutObject", "GetObject", "HeadObject", "CopyObject", "GetObjectAcl", "PutObjectAcl", "CreateMultipartUpload", "ListParts", "UploadPart", "CompleteMultipartUpload", "AbortMultipartUpload", "UploadPartCopy", "RestoreObject", "DeleteObject", "DeleteObjects", "GetObjectTorrent", "SelectObjectContent", "PutObjectLockRetention", "PutObjectLockLegalHold", "GetObjectLockRetention", "GetObjectLockLegalHold"],
    "requestParameters": {
      "bucketName": ["my-first-bucket-1-1"]
    }
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "log" {
  rule      = aws_cloudwatch_event_rule.myruler.name
  target_id = "autologgp"
  arn       = "arn:aws:logs:eu-central-1:414530803393:log-group:/aws/events/autologgp:*"
}
