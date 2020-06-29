
resource "aws_iam_user" "dynamodbUser" {
  name = "dynamodbUser"
  path = "/"
}

resource "aws_iam_access_key" "dynamodbUser" {
  user = aws_iam_user.dynamodbUser.name
}
resource "aws_iam_user_policy" "dynamodbUser_policy" {
  user = aws_iam_user.dynamodbUser.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "dynamodb:*",
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
output "dynamodbUserSecret" {
  value = aws_iam_access_key.dynamodbUser.encrypted_secret
}
output "dynamodbUserId" {
  value = aws_iam_access_key.dynamodbUser.id
}
