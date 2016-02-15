## Introduction

This is an experimental project for centralising logs from various client servers. Automate the infrastructure in aws via opsworks and cloud formation.

## Idea

Basic idea is to build a template for cloud formation which can spawn infrastructure for a centralise log management system just by clicking a deploy button.

## Softwares/ Tools

 - Elasticsearch >= 2.2.0
 - Logstash 	 >= 2.0
 - Aws Cloudformation
 - Aws Cloudformer
 - Chef v12+
 - Aws Opsworks
 - Kibana v4.4
 - Git
 - Chef Cookbooks of this repositories (ant, apt, ark, aws, bluepill, build-eesential, chef-handler, chef-sugar, curl, dmg, elasticsearch, erlang, python, rsyslog, packagecloud, runit, yum , yum-epel, logrotate, nginx, ntp, ohai, openssl, git, java) 
 (We have tried to avoid any overrite on official cookbooks ; we just wrote wrapper cookbooks when absolutely necessary: es-elk)

 ** (Avoid changing code in submodules) **

## Security groups

 Once the cloud formation template is done, it should automatically create the necessary security group and their policies in aws. For now, we have create these manually in aws. 

 Few basic idea behind a security group:

 - Firewall for port opening. We have enabled elasticsearch to find each other in the security group and form a cluster. But we have restricted access via nginx and security group from outside world reaching to our cluster.

 A basic starting idea for a security group may look like this:

 [Security Group](/assets/img/security-extension1.png "Basic Security Group")

 
__Note: This is no way a production level security group settings. This is just for us to get started with clustering and basics.__


## IAM roles

IAM roles are very important. Using this roles we give the automation a restriction on which services they can automate and have control over. IAM roles are defined via policies. We have created one role named `opsworks-elasticsearch-ec2-role` with below policy:

```

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeTags",
                "ec2:DescribeSecurityGroups",
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        }
    ]
}

```

Policy name: `OpsWorksElasticsearchEC2Discovery`


## OpsWorks


### Stacks

- Holds layers and all things related to opsworks

### Layers

- Elasticsearch
- Logstash
- Kibana

-------------
- Add all the recipes for each layers
- Everytime we spin up new instance, the instance will inherit the recipes from layer as well as other settings.
- Will help with autoScalingGroup


#### Layer reipes configuration

- Chef cookbooks
- One master wrapper cookbook
- All the necessary dependencies in one repo 
- Cookbook folder `es-elk` will have more documentation on recipes and dependencies
- For our ELK implementation we can run below recipes for each of the layers.

###### Elasticsearch

```
"java::default",
"es-elk::default",
"nginx::default"
```

###### Logstash

```
"es-elk::logstash"

```

###### Kibana

```
"es-elk::es-kibana",
"es-elk::nginx-kibana",
"es-elk::kibana"
```

### Instances

- 3 cluster nodes
( 2 powerful node and 1 smaller node )
- 1 logstash node
- 1 kibana node
(Kibana node will have an elasticsearch with `node.master: false` and `node.data: false` as settings, which will work as load balancer and we do not have to connect our kibana to the cluster, kibana can always connect to localhost)





