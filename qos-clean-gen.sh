#!/bin/sh

DL=3000000
UL=2145728
OI=wlan1

cat <<EOF
/queue type
:do { remove qos } on-error={}

/queue tree
:do { remove All-Download } on-error={}
:do { remove All-Upload } on-error={}
$(for i in $(seq 8); do echo ":do { remove P${i}-dn } on-error={}"; done)
$(for i in $(seq 8); do echo ":do { remove p${i}-up } on-error={}"; done)

:foreach item in=[/ip firewall mangle find] do={:if (\$item != "*3") do={:if (\$item != "*2") do={:if (\$item != "*1") do={/ip firewall mangle remove \$item;}}}}
EOF
