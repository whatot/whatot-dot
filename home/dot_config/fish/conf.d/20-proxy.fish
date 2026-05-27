# managed by chezmoi

function unsetproxy
    set -e PROXY_HOST PROXY_PORT
    set -e NO_PROXY ALL_PROXY HTTP_PROXY HTTPS_PROXY
    set -e no_proxy all_proxy http_proxy https_proxy
end

function setproxy
    unsetproxy

    set -l use_proxy true
    set -q USE_PROXY; and set use_proxy "$USE_PROXY"
    test "$use_proxy" = true; or return

    set -l url http://127.0.0.1:8899
    set -q PROXY_URL; and set url "$PROXY_URL"

    set -l host_port (string replace -r '^[^:]+://' '' -- "$url")
    set host_port (string replace -r '/.*$' '' -- "$host_port")
    set -l host_parts (string split -m 1 ':' -- "$host_port")
    set -gx PROXY_HOST "$host_parts[1]"
    if test (count $host_parts) -gt 1
        set -gx PROXY_PORT "$host_parts[2]"
    else
        set -gx PROXY_PORT ''
    end

    set -l no_proxy_list localhost,127.0.0.1,::1,10.0.0.0/8,192.168.0.0/16
    set -q NO_PROXY_LIST; and set no_proxy_list "$NO_PROXY_LIST"

    set -gx ALL_PROXY "$url"
    set -gx HTTP_PROXY "$url"
    set -gx HTTPS_PROXY "$url"
    set -gx all_proxy "$url"
    set -gx http_proxy "$url"
    set -gx https_proxy "$url"
    set -gx NO_PROXY "$no_proxy_list"
    set -gx no_proxy "$no_proxy_list"
end

function proxyinfo
    echo "PROXY_HOST = $PROXY_HOST"
    echo "PROXY_PORT = $PROXY_PORT"
    echo "NO_PROXY = $NO_PROXY"
    echo "ALL_PROXY = $ALL_PROXY"
    echo "HTTP_PROXY = $HTTP_PROXY"
    echo "HTTPS_PROXY = $HTTPS_PROXY"
end

setproxy
