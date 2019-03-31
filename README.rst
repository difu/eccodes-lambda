==============
eccodes-lambda
==============

Create lambda deploymentpackage for `eccodes <https://software.ecmwf.int/wiki/display/ECC/ecCodes+Home>`_ from ECMFW.


================================
Quickstart
================================

- Download this repo
- Install `docker <https://docs.docker.com>`_
- Install `docker-compose <https://docs.docker.com/compose/install>`_
- Run ``docker build -t 'difu/eccodes_lambda' .``
- Implement your lambda function in the ``lambda/`` folder and install all dependencies in here
- Run ``docker-compose run package36``
- A file ``lambda.zip`` will be created that is ready to deploy to AWS Lambda
- Set in your Lambda Environemt ``ECCODES_DEFINITION_PATH = ./definitions``


Infrastructure
""""""""""""""

All infrastructure will be deployed on AWS. To install the AWS command line tools please refer to http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html.
To create and modify the infrastructure `Terraform <https://www.terraform.io/>`_ is used. Download the ``terraform`` executable and take a look at the `getting started guide <https://www.terraform.io/intro/getting-started/install.html>`_.

- Create an AWS user and grant this user

  - AWS managed policies

    - SystemAdministrator
    - AmazonElasticFileSystemFullAccess
    - AmazonElasticMapReduceRole

  - Inline policy

  .. code-block:: json

    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1500631120000",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy",
                "iam:PutRolePolicy",
                "iam:DeleteRolePolicy",
                "iam:CreateRole",
                "iam:AttachRolePolicy",
                "iam:CreateInstanceProfile",
                "iam:AddRoleToInstanceProfile",
                "iam:PassRole",
                "iam:DetachRolePolicy",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:DeleteInstanceProfile",
                "iam:DeleteRole",
                "iam:DeleteUserPolicy",
                "iam:DeletePolicy",
                "elasticmapreduce:RunJobFlow",
                "elasticmapreduce:DescribeCluster",
                "elasticmapreduce:TerminateJobFlows",
                "lambda:AddPermission",
                "lambda:RemovePermission",
                "lambda:PublishLayerVersion",
                "apigateway:*",
            ],
            "Resource": [
                "*"
            ]
        }
    ]
    }


- Create an S3 bucket where Arcus stores its internal components etc. and name it like *my_internal_bucket*. Note that this bucket name must have an unique name. Remember that name as it is needed when you want to deploy the infrastructure.
