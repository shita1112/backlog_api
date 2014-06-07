# -*- coding: utf-8 -*-
module BacklogApi
  
  class Client
    HOST = '%s.backlog.jp'
    PATH = '/XML-RPC'
    PORT = '443' # HTTPS
    PROXY_HOST = nil
    PROXY_PORT = nil
    USE_SSL = true
    TIMEOUT = 60
        
    METHOD = 'backlog.%s'
    
    attr_accessor :space, :user, :password, :host, :client
    
    def initialize(user = nil , password = nil , space = nil)
      login_from_args(user, password, space) || login_from_netrc || login_from_environment_variables
      @client = XMLRPC::Client.new(@host, PATH, PORT, PROXY_HOST, PROXY_PORT, @user, @password, USE_SSL, TIMEOUT)
    end

    # まとめてメソッド定義
    # 例: BacklogApi::Client.new.get_timline
    BacklogApi::API_METHODS.keys.uniq.each do |api_method|
      define_method api_method.underscore, &->(params = nil) do
        call METHOD % api_method, params
      end
    end

    
    private

    def call(api_method, params = nil)
      if params
        @client.call(api_method, params)
      else
        @client.call(api_method)
      end
    end

    def login_from_netrc
      netrc = Net::Netrc.locate HOST.sub('.','') % ''
      return unless netrc
      @user = netrc.user
      @password = netrc.password
      @space = netrc.space
      @host = HOST % @space
    end

    def login_from_environment_variables
      return unless ENV["BACKLOG_USER"] && ENV["BACKLOG_PASSWORD"] && ENV["BACKLOG_SPACE"]
      @user = ENV["BACKLOG_USER"]
      @password = ENV["BACKLOG_PASSWORD"]
      @space = ENV["BACKLOG_SPACE"]
      @host = HOST % @space
    end

    def login_from_args(user = nil, password = nil, space = nil)
      return unless user && password && space
      @user = user
      @password = password
      @space = space
      @host = HOST % @space
    end



  end # Client
end # BacklogApi
