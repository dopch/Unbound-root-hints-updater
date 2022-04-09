#!/bin/bash
## First import key from Registry Administrator <nstld@verisign-grs.com> with gpg --keyserver pgp.mit.edu --receive-key 937BB869E3A238C5
curl  https://www.internic.net/domain/named.cache -o /tmp/named.cache
curl  https://www.internic.net/domain/named.cache.sig -o /tmp/named.cache.sig
gpg --verify /tmp/named.cache.sig /tmp/named.cache
if [ $? -eq 0 ]
then
    mv /tmp/named.cache /var/lib/unbound/named.cache
    rm /tmp/named.cache.sig
    systemctl restart unbound
else
    rm /tmp/named.cache /tmp/named.cache.sig
    echo Signature invalid or you forgot to import key.
fi
