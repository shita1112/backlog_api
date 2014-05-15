# -*- coding: utf-8 -*-
require "thor"
require 'xmlrpc/client'
require "active_support/core_ext"
require "awesome_print"
require "net/netrc"
require "yaml"


require "backlog_api/version"
require "backlog_api/const"
require "backlog_api/client"
require "backlog_api/command"

# TODO: ここじゃまずい気が...どこに書けばいいの？
# require "pry"
# require 'pry-doc'
require "pry-debugger"
require "tapp"
