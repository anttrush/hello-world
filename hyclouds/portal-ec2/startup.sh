#!/bin/bash

# 创建日志文件
if [ ! -d /var/log/hycloud/portal-ec2 ]; then
    mkdir -p /var/log/hycloud/portal-ec2
fi
if [ ! -f /var/log/hycloud/portal-ec2/error.log ]; then
    touch /var/log/hycloud/portal-ec2/error.log
fi
if [ ! -f /var/log/hycloud/portal-ec2/access.log ]; then
    touch /var/log/hycloud/portal-ec2/access.log
fi

# 启动apache
/etc/init.d/apache2 start

# 启动whenever
cd "$(dirname "$0")"
if [ ! -d /etc/ivic/portal-ec2 ]; then
    mkdir -p /etc/ivic/portal-ec2
fi
if [ ! -f /etc/ivic/portal-ec2/database.yml ]; then
    ln -s ./config/database.yml /etc/ivic/portal-ec2/database.yml
fi
if [ ! -x ./config/schedule.rb ]; then
    chmod 777 ./config/schedule.rb
fi
whenever -w
