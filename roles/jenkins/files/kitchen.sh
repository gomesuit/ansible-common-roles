pwd
cd /home/vagrant/provisioner
export PATH=/usr/local/ruby/bin:$PATH
bundle install
bundle ex kitchen test
