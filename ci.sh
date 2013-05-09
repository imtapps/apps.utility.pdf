#!/bin/bash

# verify user provided a name for the virtualenv
if [ -z "$1" ]; then
    echo "usage: $0 virtual_env_name"
    exit
fi

VIRTUALENV_NAME=$1

virtualenv $VIRTUALENV_NAME
. $VIRTUALENV_NAME/bin/activate

pip install -r requirements/ci.txt

nosetests --with-xunit --with-cover --cover-package=apps.utility.pdf

TEST_EXIT=$?

flake8 apps.utility.pdf --max-complexity=4 --max-line-length=120 >> jenkins_reports/.flake8
cat jenkins_reports/.flake8 | awk -F\: '{printf "%s:%s: [E]%s%s\n", $1, $2, $3, $4}' > jenkins_reports/flake8.txt
FLAKE8_EXIT=$?
let JENKINS_EXIT="$TEST_EXIT + $FLAKE8_EXIT"
if [ $JENKINS_EXIT -gt 0 ]; then
    echo "Test exit status:" $TEST_EXIT
    echo "Flake8 exit status:" $FLAKE8_EXIT
    exit $JENKINS_EXIT
fi
