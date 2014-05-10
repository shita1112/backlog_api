# -*- coding: utf-8 -*-
module BacklogApi
  class Client
    def initialize(opt = {})
      @space = opt[:space]
      @user = opt[:user]
      @password = opt[:password]

      path = '/XML-RPC'
      port = '443'
      proxy_host = nil
      proxy_port = nil
      use_ssl = true
      timeout = 60 
      host = "#{space}.backlog.jp"
      
      @client = XMLRPC::Client.new(host, path, port, proxy_host, proxy_port, user, password, use_ssl, timeout)
    end

    attr_accessor :space, :user, :password, :client
    
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
