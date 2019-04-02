==============
eccodes-lambda
==============

Create lambda deploymentpackage for `eccodes <https://software.ecmwf.int/wiki/display/ECC/ecCodes+Home>`_ from ECMWF.


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
- Set in your Lambda environment ``ECCODES_DEFINITION_PATH = ./definitions``
