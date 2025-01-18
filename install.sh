#!/bin/bash

base_python_interpreter="/usr/bin/python3.10"
project_domain="alexvtyk.beget.tech"
project_path="/home/a/alexvtyk/dr2"

read -p "Python interpreter: " base_python_interpreter
read -p "Your domain without protocol (for example, google.com): " project_domain

`$base_python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install -r requirements.txt

sed -i "s~dbms_template_path~$project_path~g" .beget/site.conf
sed -i "s~dbms_template_domain~$project_domain~g" .beget/site.conf drf2/settings.py

ln -s $project_path/.beget/site.conf /etc/nginx/sites-enabled/
ln -s $project_path/.beget/service /etc/systemd/system/


