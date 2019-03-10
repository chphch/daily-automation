# Usage example
# remote_ip=172.217.26.46
# remote_login_user=chphch
# remote_login_port=20
# remote_forwarding_port=8888
# local_forwarding_port=8889
# ssh_private_key=/Users/username/.ssh/id_rsa

remote_ip=
remote_login_user=
remote_login_port=
remote_forwarding_port=
local_forwarding_port=
ssh_private_key=

prev_server_status=0
while true; do
  server_status=$(/usr/bin/ssh -q $remote_login_user@$remote_ip -i $ssh_private_key -p $remote_login_port netstat -nlp | /usr/bin/grep :$remote_forwarding_port | /usr/bin/wc -l)
  echo $server_status $prev_server_status
  if [ $server_status -eq 1 ] && [ $prev_server_status -ne 1 ]; then
    echo connected !
    /bin/ps -A | /usr/bin/grep "[s]sh -N -f -L" | /usr/bin/cut -d' ' -f1 | /usr/bin/xargs kill -9
    /usr/bin/ssh -N -f -L localhost:$local_forwarding_port:localhost:$remote_forwarding_port -i $ssh_private_key -q -o ConnectTimeout=999999999999999999 -p $remote_login_port $remote_login_user@$remote_ip
  fi
  prev_server_status=$server_status
  /bin/sleep 1
done
