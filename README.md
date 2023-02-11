# ansible-terraform-integration

## task 1

1. terraform
    - create infrastructure
    - allow traffic through port (8090) in security group
    - create inventory file dynamically from created ec2 instances

2. Ansible
    - install nginx
    - edit nginx.conf 
    - copy index.html from local to /var/www/html
    - restart nginx service

## task 2

1. terraform
    - create infrastructure
    - allow traffic through port (8000) in security group - backend django port
    - create inventory file dynamically from created ec2 instances

2. Ansible
    - git clone repo from github
    - install pip and the requirements.txt file
    - copy ec2 instance public ip address to ALLOWED_HOSTS insettings.py file
    - running manage.py collectstatic, makemigrations, migrate, and runserver 0.0.0.0:8000

