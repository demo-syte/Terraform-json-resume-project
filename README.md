# Terraform-json-resume-project
This repo consists of all CVEngine infra deploy and provisioning code. This repo  consist code from:  Terraform Ansible Docker Jenkins, etc
# Create an architecture diagram to deploy Application

## A generic architecture consisting of:

    1 VPC
    4 Subnets: Management(22 Open), Web(Public - 443 open), App(Private), DB(Private), multi AZ.
    Note:(ALB/ELB will not be used if we can get the job done with Envoy)
    Security groups
    NAT gateway
    CIDRs defined
    S3 bucket (cvengine-v4c) private accessible from App and DB instance subnets
    IAM role for RW access S3 bucket cvengine-v4c
    IAM role to have access to all instances
    Instances in App and DB tier with IAM roles attached to access S3 bucket
    Cloudflare for DDOS prevention
    Jenkins to auto-deploy in App subnet with IAM role attached
