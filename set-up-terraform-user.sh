AWS_PROFILE=simplisafetest
NAME="terraform-user-jblacker"
TAGS='Key=creator,Value=jblacker Key=project,Value=whats_my_ip'
#aws iam create-user --user-name $NAME --tags $TAGS
# aws iam create-access-key --user-name $NAME \
#     --query "AccessKey.{AccessKeyId: AccessKeyId, SecretAccessKey: SecretAccessKey}"
aws iam put-user-policy --user-name $NAME --policy-name basic-lambda-crud-permission \
    --policy-document \
'{
    "Version": "2012-10-17",
    "Statement": [
	{
	    "Effect": "Allow",
	    "Action": [
		"iam:GetRole",
		"iam:ListRoleTags",
		"iam:TagRole",
		"iam:CreateRole",
		"iam:ListRolePolicies",
		"iam:ListAttachedRolePolicies",
		"iam:PassRole",
		"iam:DeleteRole"
	    ],
	    "Resource": "arn:aws:iam:::role/*"
	},
	{
	    "Effect": "Allow",
	    "Action": [
		"lambda:CreateFunction",
		"lambda:CreateFunctionUrlConfig",
		"lambda:TagResource",
		"lambda:ListFunctions",
		"lambda:ListVersionsByFunction",
		"lambda:GetFunction",
		"lambda:UpdateFunctionConfiguration",
		"iam:ListRoles",
		"lambda:ListFunctionUrlConfigs",
		"lambda:GetFunctionUrlConfig",
		"lambda:GetAccountSettings",
		"lambda:GetFunctionConfiguration",
		"lambda:UntagResource",
		"lambda:UpdateFunctionCode",
		"lambda:ListTags",
		"lambda:PublishVersion",
		"lambda:DeleteFunction",
		"lambda:DeleteFunctionUrlConfig",
		"lambda:GetPolicy",
		"ec2:DescribeAccountAttributes",
	    ],
	    "Resource": "*"
	},
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::700488736558:role/*lambda*"
        }
    ]
}'
# aws iam create-policy --policy-name basic-lambda-crud-permission \
#     --description "Permisions for Terraform to create and destroy Lambda functions, URLs, and associated IAM roles" \
#     --query arn:aws:iam::700488736558:policy/basic-lambda-crud-permission
#     --policy-document \
# '{
#     "Version": "2012-10-17",
#     "Statement": [
# 	{
# 	    "Effect": "Allow",
# 	    "Action": [
# 		"iam:GetRole",
# 		"iam:ListRoleTags",
# 		"iam:TagRole",
# 		"iam:CreateRole",
# 		"iam:DeleteRole"
# 	    ],
# 	    "Resource": "arn:aws:iam:::role/*"
# 	},
# 	{
# 	    "Effect": "Allow",
# 	    "Action": [
# 		"lambda:CreateFunction",
# 		"lambda:CreateFunctionUrlConfig",
# 		"lambda:TagResource",
# 		"lambda:ListFunctions",
# 		"lambda:ListVersionsByFunction",
# 		"lambda:GetFunction",
# 		"lambda:UpdateFunctionConfiguration",
# 		"iam:ListRoles",
# 		"lambda:ListFunctionUrlConfigs",
# 		"lambda:GetFunctionUrlConfig",
# 		"lambda:GetAccountSettings",
# 		"lambda:GetFunctionConfiguration",
# 		"lambda:UntagResource",
# 		"lambda:UpdateFunctionCode",
# 		"lambda:ListTags",
# 		"lambda:PublishVersion",
# 		"lambda:DeleteFunction",
# 		"lambda:DeleteFunctionUrlConfig",
# 		"lambda:GetPolicy"
# 	    ],
# 	    "Resource": "*"
# 	}
#     ]
# }'
# aws iam attach-user-policy --user-name $NAME --policy-arn arn:aws:iam::700488736558:policy/basic-lambda-crud-permission
