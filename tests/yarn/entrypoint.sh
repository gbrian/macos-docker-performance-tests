#!/bin/bash

mkdir simple-project
cp package.json simple-project/
(cd simple-project && yarn install)
rm -rf simple-project