resource "aws_s3_bucket" "example" {
bucket = "my-nginx-log-bucket"
acl = "private"
region = "us-east-1"
}

resource "aws_s3_bucket_policy" "example" {
bucket = aws_s3_bucket.example.id
policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Principal": {
"AWS": "arn:aws:iam::<account_id>:role/<nginx_role>"
},
"Action": [
"s3:PutObject"
],
"Resource": [
"arn:aws:s3:::my-nginx-log-bucket/*"
]
}
]
}
EOF
}