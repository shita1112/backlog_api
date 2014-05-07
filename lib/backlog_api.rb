# -*- coding: utf-8 -*-
require "backlog_api/version"
require 'xmlrpc/client' 

module BacklogApi
  class Client

    # 初期化
    def initialize
      # 環境変数をセットしてね
      @host = ENV["HOST"]
      @user = ENV["USER"]
      @password = ENV["PASSWORD"]

      path = '/XML-RPC'
      port = '443'
      proxy_host = nil
      proxy_port = nil
      use_ssl = true
      timeout = 60 
      
      @client = XMLRPC::Client.new(host, path, port, proxy_host, proxy_port, user, password, use_ssl, timeout)
    end
    # アクセッサ
    attr_accessor :host, :user, :password, :client

    # タイムラインを取得
    def get_timeline    
      @client.call('backlog.getTimeline')
    end

    # 課題追加
    def create_issue(opt = {})
      @client.call(
        'backlog.createIssue', {
          projectId: ENV["PROJECT_ID"],
          assignerId: ENV["USER"],
          summary: opt[:summary],
        }
      )
    end

    # プロジェクト取得
    def get_projects
      @client.call('backlog.getProjects')
    end




  end # Client
end # BacklogApi
