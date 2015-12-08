
yum -y install zlib zlib-devel binutils perl gcc gcc-c++
yum -y install vim

rpm -Uvh /vagrant/epel-release-6-8.noarch.rpm
rpm -Uvh /vagrant/erlang-solutions-1.0-1.noarch.rpm

sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/epel.repo
sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/erlang_solutions.repo

yum -y install erlang --enablerepo=epel,erlang_solutions

rpm -Uvh /vagrant/rabbitmq-server-3.1.5-1.noarch.rpm
#rpm -Uvh /vagrant/rabbitmq-server-3.4.4-1.noarch.rpm

echo -n "SHOWMETHEMONEY123456" > /var/lib/rabbitmq/.erlang.cookie
chown rabbitmq.rabbitmq /var/lib/rabbitmq/.erlang.cookie
chmod 400 /var/lib/rabbitmq/.erlang.cookie

rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_shovel
rabbitmq-plugins enable rabbitmq_shovel_management

#ln -s /vagrant/rabbitmq.config /etc/rabbitmq/rabbitmq.config
cp /vagrant/rabbitmq.config /etc/rabbitmq/rabbitmq.config

service rabbitmq-server start
chkconfig rabbitmq-server on

echo "192.168.33.10 bunny1" >> /etc/hosts
echo "192.168.33.11 bunny2" >> /etc/hosts
