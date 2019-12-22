resource "aws_s3_bucket" "grafana-test-s3" {
  bucket = "am-grafana-test-ansible-playbook"
  acl    = "private"
  versioning {
    enabled = true
    }
}

resource "aws_s3_bucket_object" "grafana-test-s3" {
  key    = "grafana-test-ansible"
  bucket = "${aws_s3_bucket.grafana-test-s3.id}"
  source = "grafana-ansible.zip"
}
