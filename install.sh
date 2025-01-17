#!/bin/bash

base_python_interpreter="python3.12.6"
project_domain="alexvtyk.beget.tech"
project_path="C:\Users\1\drf2"

read -p "Python interpreter: " base_python_interpreter
read -p "Your domain without protocol (for example, google.com): " project_domain

`$base_python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install -r requirements.txt

sed -i "s~dbms_template_path~$project_path~g" beget/site.conf
sed -i "s~dbms_template_domain~$project_domain~g" beget/site.conf drf2/settings.py

sudo ln -s $project_path/beget/site.conf /etc/nginx/sites-enabled/
sudo ln -s $project_path/beget/service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start beget
sudo systemctl enable beget
sudo service nginx restart