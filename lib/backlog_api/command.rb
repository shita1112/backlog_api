# -*- coding: utf-8 -*-
module BacklogApi
  class Command < Thor

    # まとめて定義
    # 例: $ backlog get_timeline
    BacklogApi::API_METHODS.keys.uniq.each do |api_method|
      # オプション
      # とりあえず必須パラメータだけオプションに指定できるようにした
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

        # APIのパラメータの型の違いを吸収
        # TODO: 微妙...scalarに関してはコマンドライン引数で取得するように修正する
        params = 
          case BacklogApi::API_METHODS[api_method]["type"]
          when 'scalar'
            options.values[0]
          when 'struct'
            options          
          when nil
            nil
          end

        response = Client.new.send api_method.underscore, params
        ap response
      end

      # Sinatraアプリ起動
      method_option( :server,
        type: :string,
        desc: :server,
        required: false,
        aliases: "s"
        )
      desc :server, '課題管理用のwebインタフェースを立ち上げる'
      def server
        puts "Start Sinatra app..."
        root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
        exec "cd #{root} && rackup config.ru"
      end

    end


    
  end
end
