ipaddr=$(grep -Po 'inet.\K[^ /]+' <<< `ip addr show eth0 | grep "inet "`)
echo $ipaddr