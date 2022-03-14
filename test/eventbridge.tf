resource "aws_s3_bucket" "log-bucket" {
  bucket = "log-bucket-1-1"
}

resource "aws_s3_bucket_notification" "s3-notif" {
  bucket = aws_s3_bucket.log-bucket.id
  eventbridge = true
}

resource "aws_cloudwatch_event_rule" "myruler" {
  name        = "log-bucket-test-rule"
  description = "Capture each AWS Console Sign In"

  event_pattern = <<EOF
{
  "source": ["aws.s3"],
  "detail-type": ["Object Access Tier Changed", "Object ACL Updated", "Object Created", "Object Deleted", "Object Restore Completed", "Object Restore Expired", "Object Restore Initiated", "Object Storage Class Changed", "Object Tags Added", "Object Tags Deleted"]
  "detail": {
    "eventSource": ["s3.amazonaws.com"],
    "eventName": ["ListObjects", "ListObjectVersions", "PutObject", "GetObject", "HeadObject", "CopyObject", "GetObjectAcl", "PutObjectAcl", "CreateMultipartUpload", "ListParts", "UploadPart", "CompleteMultipartUpload", "AbortMultipartUpload", "UploadPartCopy", "RestoreObject", "DeleteObject", "DeleteObjects", "GetObjectTorrent", "SelectObjectContent", "PutObjectLockRetention", "PutObjectLockLegalHold", "GetObjectLockRetention", "GetObjectLockLegalHold"],
    "requestParameters": {
      "bucketName": ["${aws_s3_bucket.log-bucket.id}"]
    }
  }
}
EOF
}

resource "aws_cloudwatch_log_group" "s3-logs" {
  name = "s3-logs"
}

resource "aws_cloudwatch_event_target" "log" {
  rule      = aws_cloudwatch_event_rule.myruler.name
  target_id = "autologgp"
  /* arn       = "arn:aws:logs:eu-central-1:414530803393:log-group:/aws/events/autologgp" */
  arn       = aws_cloudwatch_log_group.s3-logs.arn
}
