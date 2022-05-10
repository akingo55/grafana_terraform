resource "aws_iam_instance_profile" "grafana-test" {
  name = "grafana-test-ec2"
  role = aws_iam_role.grafana-test.name
}

resource "aws_iam_role" "grafana-test" {
  name = "ec2-grafana-test"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws_ssm" {
  role       = "${aws_iam_role.grafana-test.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy" "s3" {
  name = "s3-grafana-test"
  role = "${aws_iam_role.grafana-test.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:HeadBucket"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "${aws_s3_bucket.grafana-test.arn}",
        "${aws_s3_bucket.grafana-test.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "cloudwatch-grafana-test"
  role = "${aws_iam_role.grafana-test.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:HeadBucket"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:GetMetricData",
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
