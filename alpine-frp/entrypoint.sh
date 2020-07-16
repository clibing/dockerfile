#!/bin/bash

# set -e
# frp type, server or client
FRP_TYPE=${FRP_TYPE:-}

function frps_config(){
[ ! -f ${FRPS_CONF} ] && cat > ${FRPS_CONF}<<-EOF
[common]
bind_addr = 0.0.0.0
bind_port = ${BIND_PORT:-5443}
bind_udp_port = ${BIND_UDP_PORT:-5444}
kcp_bind_port = ${KCP_BIND_PORT:-5443}

# auth token
token = ${TOKEN:-e7047cb7b184e9ca}

dashboard_addr = 0.0.0.0
dashboard_port = ${DASHBOARD_PORT:-5445}
dashboard_user = ${DASHBOARD_USER:-clibing}
dashboard_pwd = ${DASHBOARD_PWD:-e7047cb7b184e9ca}

max_pool_count = ${MAX_POOL_COUNT:-50}
max_ports_per_client = ${MAX_PORTS_PER_CLIENT:-0}
authentication_timeout = ${AUTHENTICATION_TIMEOUT:-900}

tcp_mux = ${TCP_MUX:-true}

log_file = ${FRPS_LOG}
log_level = ${LOG_LEVEL:-info}
log_max_days = ${LOG_MAX_DAYS:-3}

vhost_http_port = ${VHOST_HTTP_PORT:-80}
vhost_https_port = ${VHOST_HTTPS_PORT:-443}
subdomain_host = 

# end
EOF

cat ${FRPS_CONF}
echo "create server frps.ini ok"
}

function frpc_config(){
if [ ${SERVER_ADDR} = '' ];then 
  echo "must set server addr"
  exit 1
fi

[ ! -f ${FRPC_CONF} ] && cat > ${FRPC_CONF}<<-EOF
[common]
server_addr = ${SERVER_ADDR:-0.0.0.0}
server_port = ${SERVER_PORT:-5443}

token = ${TOKEN:-e7047cb7b184e9ca}

pool_count = ${POOL_COUNT:5}

tcp_mux = ${TCP_MUX:-true}

login_fail_exit = false

log_file = ${FRPC_LOG}
log_level = ${LOG_LEVEL:-info}
log_max_days = ${LOG_MAX_DAYS:-3}

# communication protocol used to connect to server
# now it supports tcp and kcp, default is tcp
protocol = ${CONNECT_PROTOCOL:-tcp}

${USER_CONFIG} 

# end
EOF

cat ${FRPC_CONF}
echo "create server frpc.ini ok"
}


if [ "${FRP_TYPE}" = "SERVER" ];then {
    echo "run frp by server mode"
    rm -f ${FRPS_LOG} > /dev/null 2>&1
    frps_config
    echo "Starting frps $(${FRPS_BIN} -v) ..."
    ${FRPS_BIN} -c ${FRPS_CONF} &
    sleep 0.5
    netstat -ntlup | grep "frps"
    echo "console log"
    tail -f ${FRPS_LOG}
} elif [ "${FRP_TYPE}" = "CLIENT" ];then {
    echo "run frp by client mode"
    rm -f ${FRPC_LOG} > /dev/null 2>&1
    frpc_config
    echo "Starting frpc $(${FRPC_BIN} -v) ..."
    ${FRPC_BIN} -c ${FRPC_CONF} &
    sleep 0.5
    netstat -ntlup | grep "frpc"
    exec "tail" -f ${FRPC_LOG}
} else {
    echo "select mode FRP_TYPE = 'SERVER' or 'CLIENT'"
}
fi

