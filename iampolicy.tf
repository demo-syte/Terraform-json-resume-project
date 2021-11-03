# This is to allow S3 Access to App & Db Server
resource "aws_iam_role" "S3_Access_role" {
name = "S3_Access_role"
assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": "sts:AssumeRole",
"Principal": {
"Service": "ec2.amazonaws.com"
},
"Effect": "Allow",
"Sid": ""
}
]
}
EOF
tags = {
tag-key = "tag-value"
Owner = "Roshan"
}
}


#Create EC2 Instance Profile Which gives access to App/DB boxes to S3 Bucket
resource "aws_iam_instance_profile" "S3_Access_profile" {
name = "S3_Access_profile"
role = "${aws_iam_role.S3_Access_role.name}"

tags = {
    Name = "S3 Access profile for App/DB S3 Access"
    owner = "Roshan"
}
}


#Adding IAM Policies
#To give full access to S3 bucket
resource "aws_iam_role_policy" "S3_Access_policy" {
name = "S3_Access_policy"
role = "${aws_iam_role.S3_Access_role.id}"
policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": [
"S3:*"
],
"Effect": "Allow",
"Resource": "*"
}
]
}
EOF
}

/*resource "aws_instance" "role-S3_Access" {
ami = "ami-0bbe6b35405ecebdb"
instance_type = "t2.micro"
iam_instance_profile =
"${aws_iam_instance_profile.S3_Access_profile.name}"
key_name = "myS3_Accesspubkey"
}*/