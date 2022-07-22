#!/bin/bash

function update_known_hosts() {
    host=$1
    ssh-keygen -R $host
    ssh-keyscan -t rsa $host >> ~/.ssh/known_hosts
    ssh-keyscan -H $host >> ~/.ssh/known_hosts
}

HOSTS=(github.com  gitlab.com)
for host in ${HOSTS[@]} ; do
    update_known_hosts $host
done