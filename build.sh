#!/bin/bash
aws codeartifact login --tool pip --repository python-common --domain trc-platform --domain-owner 710915658486 --region us-east-2
python -m build . --sdist

aws codeartifact login --tool twine --repository python-common --domain trc-platform --domain-owner 710915658486 --region us-east-2
twine upload --repository codeartifact dist/*.tar.gz
