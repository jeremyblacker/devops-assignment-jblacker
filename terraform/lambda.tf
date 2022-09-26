# Looks like there are other candidates in the account
locals {
  account_id           = data.aws_caller_identity.current.account_id
  lambda_function_name = "whats_my_ip_jblacker"
}

# Need the lamba function to be able to create a log group and permission to log to it
resource "aws_iam_policy" "iam_policy_for_lambda" {
  name         = "iam_policy_for_lambda_jblacker"
  description  =  "basic policy for lambda role"
  tags         = var.common_tags  
  policy       = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "logs:CreateLogGroup",
      "Resource": "arn:aws:logs:${var.aws_region}:${local.account_id}:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${var.aws_region}:${local.account_id}:log-group:/aws/lambda/${local.lambda_function_name}:*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "iam_role_for_lambda" {
  name = "iam_role_for_lambda_jblacker"
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

resource "aws_iam_role_policy_attachment" "iam_role_for_lambda_policy_attachment" {
  role       = aws_iam_role.iam_role_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "whats_my_ip_jblacker" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function.zip"
  function_name = local.lambda_function_name
  description   = "Returns the IP address of the requester in text/html"
  role          = aws_iam_role.iam_role_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("lambda_function.zip")

  runtime = "python3.9"

  tags = var.common_tags

}

# Needed to allow access from everywhere to the lamba function URL
resource "aws_lambda_permission" "all_access" {
  statement_id           = "url"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.whats_my_ip_jblacker.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}

# Create a URL to use the web app
resource "aws_lambda_function_url" "whats_my_ip_url_jblacker" {
  function_name      = aws_lambda_function.whats_my_ip_jblacker.function_name
  authorization_type = "NONE"
}
