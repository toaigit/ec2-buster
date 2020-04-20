#!/bin/bash

. ./vars.env

cat ebs.templ      | gomplate > ebs.tf
cat eip.templ      | gomplate > eip.tf
cat userdata.templ | gomplate > userdata.sh
cat main.templ     | gomplate > main.tf
