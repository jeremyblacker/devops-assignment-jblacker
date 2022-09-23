#!/bin/bash -x
AWS_PROFILE=simplisafetest
NAME="terraform-user-jblacker"
TAGS='Key=creator,Value=jblacker Key=project,Value=whats_my_ip'
# aws iam create-user --user-name $NAME --tags $TAGS
# aws iam create-access-key --user-name $NAME \
#      --query "AccessKey.{AccessKeyId: AccessKeyId, SecretAccessKey: SecretAccessKey}"
aws iam put-user-policy --user-name $NAME --policy-name basic-lambda-crud-permission \
    --policy-document \
'{
    "Version": "2012-10-17",
    "Statement": [
	{
	    "Effect": "Allow",
	    "Action": [
                "iam:UpdateAssumeRolePolicy",
                "iam:GetPolicyVersion",
                "iam:ListRoleTags",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:PutRolePolicy",
                "iam:DetachRolePolicy",
                "iam:ListAttachedRolePolicies",
                "ec2:DescribeAccountAttributes",
                "iam:ListRolePolicies",
                "iam:ListPolicies",
                "iam:GetRole",
                "iam:GetPolicy",
                "iam:TagPolicy",
                "iam:UntagRole",
                "iam:PutRolePermissionsBoundary",
                "iam:TagRole",
                "iam:ListPoliciesGrantingServiceAccess",
                "iam:DeletePolicy",
                "iam:DeleteRolePolicy",
                "iam:ListPolicyTags",
                "iam:CreatePolicyVersion",
                "iam:ListRoles",
                "iam:CreatePolicy",
                "iam:ListPolicyVersions",
                "lambda:*",
                "iam:UntagPolicy",
                "iam:DeletePolicyVersion",
                "iam:SetDefaultPolicyVersion",
		"logs*",
                "iam:ListInstanceProfilesForRole",
		],
	    "Resource": "*"
	},
        {
            "Effect": "Allow",
            "Action": [
		"iam:PassRole",
		"iam:DeleteRole",
	    ],
            "Resource": [
                "arn:aws:iam:::role/*lambda*",
	    ]
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
