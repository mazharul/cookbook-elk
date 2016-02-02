## Introduction

This is an experimental project for centralising logs from various client servers. Automate the infrastructure in aws via opsworks and cloud formation.

## Idea

Basic idea is to build a template for cloud formation which can spawn infrastructure for a centralise log management system just by clicking a deploy button.

## Softwares/ Tools

 - Elasticsearch >= 2.1.1
 - Logstash 	 >= 2.0
 - Aws Cloudformation
 - Aws Cloudformer
 - Chef v12+
 - Aws Opsworks
 - Kibana v4.0+
 - Git
 - Chef Cookbooks of this repositories (ant, apt, ark, aws, bluepill, build-eesential, chef-handler, chef-sugar, curl, dmg, elasticsearch, erlang, python, rsyslog, packagecloud, runit, yum , yum-epel, logrotate, nginx, ntp, ohai, openssl, git, java) 
 (We have tried to avoid any overrite on official cookbooks ; we just wrote wrapper cookbooks when absolutely necessary: es-elk)

 ## Security groups

 Once the cloud formation template is done, it should automatically create the necessary security group and their policies in aws. For now, we have create these manually in aws. 

 Few basic idea behind a security group:

 - Firewall for port opening. We have enabled elasticsearch to find each other in the security group and form a cluster. But we have restricted access via nginx and security group from outside world reaching to our cluster.

 A basic starting idea for a security group may look like this:

 [Security Group](/assets/img/security-extension1.png "Basic Security Group")

 
__Note: This is no way a production level security group settings. This is just for us to get started with clustering and basics.__


## IAM roles

IAM roles are very important. Using this roles we give the automation a restriction on which services they can automate and have control over. IAM roles are defined via policies. 