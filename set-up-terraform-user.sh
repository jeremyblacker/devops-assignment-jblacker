#!/bin/bash -x
AWS_PROFILE=simplisafetest
NAME="terraform-user-jblacker"
TAGS='Key=creator,Value=jblacker Key=project,Value=whats_my_ip'
aws iam create-user --user-name $NAME --tags $TAGS
aws iam create-access-key --user-name $NAME \
    --query "AccessKey.{AccessKeyId: AccessKeyId, SecretAccessKey: SecretAccessKey}"

# Want to restrict permissions of the terraform user to just what's needed for this project
aws iam put-user-policy --user-name $NAME --policy-name basic-lambda-crud-permission \
    --policy-document \
'{
    "Version": "2012-10-17",
    "Statement": [
	{
	    "Effect": "Allow",
	    "Action": [
               "lambda:*",
                "ec2:DescribeAccountAttributes",
                "iam:UpdateAssumeRolePolicy",
                "iam:GetPolicyVersion",
                "iam:ListRoleTags",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:PutRolePolicy",
                "iam:DetachRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListRolePolicies",
                "iam:ListPolicies",
                "iam:GetRole",
                "iam:GetPolicy",
                "iam:TagPolicy",
                "iam:UntagRole",
                "iam:PutRolePermissionsBoundary",
                "iam:TagRole",
                "iam:ListPoliciesGrantingServiceAccess",
                "iam:ListPolicyTags",
                "iam:CreatePolicyVersion",
                "iam:ListRoles",
                "iam:CreatePolicy",
                "iam:ListPolicyVersions",
                "iam:UntagPolicy",
                "iam:SetDefaultPolicyVersion",
                "iam:ListInstanceProfilesForRole",
		"iam:PassRole",
		"iam:DeleteRole",
                "iam:DeletePolicy",
                "iam:DeleteRolePolicy",
                "iam:DeletePolicyVersion"
		],
	    "Resource": "*"
	}
    ]
}'
#  Tried to restrict the terraform user's access for creating/changing/destroying iam roles and polies to just things that I'm working on
#       {
#             "Effect": "Allow",
#             "Action": [
# 		"iam:PassRole",
# 		"iam:DeleteRole",
#                 "iam:DeletePolicy",
#                 "iam:DeleteRolePolicy",
#                 "iam:DeletePolicyVersion"
# 	    ],
# 	    "Resource": "*",
# 	    "Condition": {
# 		"StringLike": {
# 		    "iam:AssociatedResourceArn": "arn:aws:iam::*:role/*jblacker*"
# 		}
# 	    }
#         }
#     ]
# }'
