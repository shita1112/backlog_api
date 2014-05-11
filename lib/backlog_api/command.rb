# -*- coding: utf-8 -*-
module BacklogApi
  class Command < Thor

    
    ##################################################################################
    # サブコマンドの説明
    ##################################################################################
    desc "get_timeline", "タイムラインを取得するよ"




    ##################################################################################
    # サブコマンド定義
    ##################################################################################
    # まとめて定義
    # 例: $ backlog get_timeline
    BacklogApi::API_METHODS.keys.map(&:underscore).each do |api_method|

      # オプション
      method_option( :from,
        type: :string,
        desc: "説明だよ",	
        required: false,
        default: "a",
        aliases: "-f"
        )

      # サブコマンド定義
      define_method api_method do
        response = Client.new.send api_method
        ap response
      end
      
    end
    
  end
end
