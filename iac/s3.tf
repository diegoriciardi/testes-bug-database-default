resource "aws_s3_bucket" "maninho" {
  bucket = "meubucketviatftestebugdatabasedefault"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}