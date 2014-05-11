# -*- coding: utf-8 -*-
module BacklogApi
  class Command < Thor

    
    ##################################################################################
    # サブコマンドの説明
    ##################################################################################
    # desc "get_timeline", "タイムラインを取得するよ"




    ##################################################################################
    # サブコマンド定義
    ##################################################################################
    # まとめて定義
    # 例: $ backlog get_timeline
    BacklogApi::API_METHODS.keys.uniq.each do |api_method|
      # オプション
      # とりあえず必須パラメータだけパラメータに指定できるようにした
      BacklogApi::API_METHODS[api_method]["required"].each do |key|
        method_option( key,
          type: :string,
          desc: key,
          required: true,
          aliases: "-#{key[0]}"
          )
      end
      
      # 説明(必須)
      desc api_method.underscore, (BacklogApi::API_METHODS[api_method]['desc'].presence || api_method)
      # サブコマンド定義
      define_method api_method.underscore, &->(params = nil) do
        response = Client.new.send api_method.underscore
        ap response
      end

    end


    
  end
end
