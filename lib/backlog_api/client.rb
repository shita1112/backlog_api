# -*- coding: utf-8 -*-
module BacklogApi
  
  class Client
    HOST = '%s.backlog.jp'
    PATH = '/XML-RPC'
    PORT = '443'
    PROXY_HOST = nil
    PROXY_PORT = nil
    USE_SSL = true
    TIMEOUT = 60
        
    METHOD = 'backlog.%s'
    
    attr_accessor :space, :user, :password, :client
    
    def initialize(opt = {})
      @space = opt[:space] || ENV["SPACE"]
      @user = opt[:user] || ENV["USER"]
      @password = opt[:password] || ENV["PASSWORD"]
      
      @client = XMLRPC::Client.new(HOST % @space, PATH, PORT, PROXY_HOST, PROXY_PORT, @user, @password, USE_SSL, TIMEOUT)
    end

    # まとめてメソッド定義
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


  end # Client
end # BacklogApi
