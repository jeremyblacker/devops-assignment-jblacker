# Looks like there are other candidates in the account
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_jblacker"
  tags = var.common_tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_lambda_function" "whats_my_ip_jblacker" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "whats_my_ip_jblacker.zip"
  function_name = "whats_my_ip_jblacker"
  description   = "Returns the IP address of the requester in text/html"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "handler"

  source_code_hash = filebase64sha256("whats_my_ip_jblacker.zip")

  runtime = "python3.9"

  tags = var.common_tags

}

# resource "aws_lambda_function_url" "whats_my_ip_url_jblacker" {
#   function_name      = aws_lambda_function.whats_my_ip_function_jblacker.function_name
#   authorization_type = "NONE"
# }

# aws lambda add-permission \
# --function-name lambda-python-hello-world \
# --action lambda:InvokeFunctionUrl \
# --principal "*" \
# --function-url-auth-type "NONE" \
#   --statement-id url


# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "logs:CreateLogGroup",
#       "Resource": "arn:aws:logs:us-east-1::*"
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
# 	"logs:CreateLogStream",
# 	"logs:PutLogEvents"
#       ],
#       "Resource": [
# 	"arn:aws:logs:us-east-1::log-group:/aws/lambda/pythonHelloWorld:*"
#       ]
#     }
#   ]
# }
