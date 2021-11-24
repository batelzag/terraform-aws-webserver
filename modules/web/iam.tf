# Creates new role for ec2-s3-write access
resource "aws_iam_role" "ec2-s3-write-role" {
  name               = "ec2-s3-write-role"
  description        = "ec2 role to upload access logs to s3 bucket"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
# Creates EC2 profile - to link IAM role
resource "aws_iam_instance_profile" "ec2-s3-write-profile" {
  name = "ec2-s3-write-profile"
  role = aws_iam_role.ec2-s3-write-role.name
}

# Adds IAM policy which allows EC2 instance to access S3 bucket with write permissions
resource "aws_iam_role_policy" "ec2-s3-write-policy" {
  name    = "ec2-s3-write-policy"
  role    = aws_iam_role.ec2-s3-write-role.id

  policy  = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
         "s3:Get*",
          "s3:List*",
          "s3:Put*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}