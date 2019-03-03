# Usage example
# remote_ip=172.217.26.46
# remote_login_user=chphch
# remote_login_port=20
# remote_forwarding_port=8888
# local_forwarding_port=8889

remote_ip=
remote_login_user=
remote_login_port=
remote_forwarding_port=
local_forwarding_port=

/usr/bin/pgrep 'ssh$' | /usr/bin/xargs kill -9
/usr/bin/ssh -N -f -L localhost:$local_forwarding_port:localhost:$remote_forwarding_port -q -p $remote_login_port $remote_login_user@$remote_ip
