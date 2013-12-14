#!/usr/bin/env bash
export PATH=/usr/local/bin:$PATH
export BANK_USR=user
export BANK_PW=password
cd bice-selenium
/home/web/.rbenv/shims/ruby ./run.rb >> run.log 2>&1
