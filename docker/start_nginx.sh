#!/bin/sh

# mock用户sip-uri设置
# sed -i 's/osips/osips:5060/g' /usr/share/nginx/html/get_*.json

# 用户端前缀
export NGINX_RCS_WEB_APP_BASE_URL=${NGINX_RCS_WEB_APP_BASE_URL:-\/}

# 定义连接基数区域，10m 可以储存 320000 个并发会话
export NGINX_LIMIT_CONN_ZONE=${NGINX_LIMIT_CONN_ZONE:-10m}
# 是限制每个IP只能发起8000个并发连接
export NGINX_LIMIT_CONN_CONNIP=${NGINX_LIMIT_CONN_CONNIP:-8000}
# 指定当触发limit的时候日志打印级别
export NGINX_LIMIT_CONN_LOG_LEVEL=${NGINX_LIMIT_CONN_LOG_LEVEL:-error}
# 回复被禁用的连接请求时的状态码
export NGINX_LIMIT_CONN_STATUS=${NGINX_LIMIT_CONN_STATUS:-503}
# 达到阀值后开始限速(字节)
export NGINX_LIMIT_RATE_AFTER=${NGINX_LIMIT_RATE_AFTER:-300m}
# 限制向客户端传输数据的速度(Byte/s)
export NGINX_LIMIT_RATE=${NGINX_LIMIT_RATE:-300k}
# 指定等待client发送一个包体的超时时间
export NGINX_CLIENT_BODY_TIMEOUT=${NGINX_CLIENT_BODY_TIMEOUT:-60s}
# 指定等待client发送一个包头的超时时间
export NGINX_CLIENT_HEADER_TIMEOUT=${NGINX_CLIENT_HEADER_TIMEOUT:-60s}
# keep-alive连接超时时间
export NGINX_KEEPALIVE_TIMEOUT=${NGINX_KEEPALIVE_TIMEOUT:-75s}
# 服务端向客户端传输数据的超时时间
export NGINX_SEND_TIMEOUT=${NGINX_SEND_TIMEOUT:-60s}
# 隐藏版本号
export NGINX_SERVER_TOKENS=${NGINX_SERVER_TOKENS:-off}
export NGINX_SERVER_TOKENS=${NGINX_SERVER_TOKENS:-off}

echo "启动 Nginx server for e2e5gmx_web-app"

envsubst '$NGINX_RCS_WEB_APP_BASE_URL $NGINX_LIMIT_CONN_ZONE $NGINX_LIMIT_CONN_CONNIP $NGINX_LIMIT_CONN_LOG_LEVEL $NGINX_LIMIT_CONN_STATUS $NGINX_LIMIT_RATE_AFTER $NGINX_LIMIT_RATE $NGINX_CLIENT_BODY_TIMEOUT $NGINX_CLIENT_HEADER_TIMEOUT $NGINX_KEEPALIVE_TIMEOUT $NGINX_SEND_TIMEOUT $NGINX_SERVER_TOKENS' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'