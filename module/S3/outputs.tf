output "bucket" {
  description = "Name newly created SQS Queue"
  value = "${aws_s3_bucket.bucket.id}"
}