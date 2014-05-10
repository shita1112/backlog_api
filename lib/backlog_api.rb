# -*- coding: utf-8 -*-
require "thor"
require 'xmlrpc/client'
require "active_support/core_ext"

require "backlog_api/version"
require "backlog_api/client"
require "backlog_api/command"


module BacklogApi
  # BacklogApi::Command,BacklogApi::Clientで利用するからここがいいのかなー?
  API_METHODS = %w[getTimeline getProjects createIssue].freeze
end







