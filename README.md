# DevOps Take Home Assignment

We are most interested in how you go about learning the tools and environment and how you decompose the problem. As such, the problem does not have any particular "right" answer.

## Usage notes

Create the terraform user with restricted access by running the set-up-terraform-user.sh and add the credentials to your ~/.aws/credentials file
```
[jblacker@MacBook-Pro-2.local:~/repos/devops-assignment-jblacker] [jblacker-dev ↑·1|✚ 2…2]✔
 $ ./set-up-terraform-user.sh
Add the following credentials to your ~/.aws/credentials:
{
     "AccessKeyId": "XXXXXXXXXXXXXXXXXXXX",
     "SecretAccessKey": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
```
Make a terraform plan
```
terraform plan --out"terraform.plan"
```

Run the terraform plan
```
terraform apply "terraform.plan"
```

Get the function URL to test out
```
[jblacker@MacBook-Pro-2.local:~/repos/devops-assignment-jblacker] [jblacker-dev ↑·1|✚ 2…2]✔
 $ aws lambda get-function-url-config --function-name whats_my_ip_jblacker | grep FunctionUrl | awk -F'"' '{print $4}'
 https://frym2wnairyi4aulsltm77cn440pckns.lambda-url.us-east-1.on.aws/
```

After you are done testing, you can destroy the resources (the logs remain)
```
terraform plan -destroy --out"terraform.plan"
terraform apply "terraform.plan"
```


## The Test

For this task we would like a single page web application, implemented in the language of your choice, that will return the ip address of the requester when the page is loaded. Basically, a simplified version of ifconfig.me or whatismyip.com.

Along with this, you should automate the process of spinning up an AWS compute resource (e.g., EC2 instance, ECS or EKS, Fargate, Lambda, etc)  and deploying your application to it. You are allowed to script directly against the AWS API or to leverage other preexisting tools or libraries. Please also include a script/method for cleaning up the resources that were created when you are done.

## What We Look For

This test is not so much about proving you know "all the things" and more about showing how you work through problems like this. As such you are encouraged to reach out and bounce ideas off of us or to ask for guidance. You are also encouraged to share your research and thoughts as you work through the task in a README or notes document.

## Communicate With The Team

You will be invited to a Slack channel where you can ask us any and all questions in real-time (assuming business hours 😄) as you go through the work.

## NOTE

Always be cautious with AWS keys/credentials and git repositories. We strongly suggest looking at "Named Profiles" which is supported by all official AWS tools and libraries and most third party tools working with AWS as well.
