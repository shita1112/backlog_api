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
    end

    # Sinatraアプリ起動
    method_option( :server,
      type: :string,
      desc: :server,
      required: false,
      aliases: "s"
      )
    desc :server, '課題管理用のwebインタフェースを立ち上げます。'
    def server
      puts "Start sinatra app..."
      root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
      exec "cd #{root} && rackup config.ru"
    end

    # 進捗状況を表示
    desc :progress, 'プロジェクトの進捗状況を表示します'
    def progress
      # data = [
      #   {:foo => '123', :bar => '456', :buz => '789'},
      #   {:foo => 'abc', :bar => 'def', :buz => 'ghi'},
      #   {:foo => 'alpha', :bar => 'beta', :buz => 'gamma'},
      # ]
      
      issues = BacklogApi::Client.new.find_issue(projectId: PROJECT_ID)
      issues = group_issues_by_assigner(issues)
      data = issues.map do |name,issues|
        {
          "名前" => (name || '未割当'),
          "進捗(#{"|".blue}完了 #{"|".green}処理済み #{"|".yellow}処理中 #{"|".red}未対応)" => progress_bar(issues),
          "完了件数" => completed_count_per_total_count(issues),
          "完了率" => progress_rate(issues),
        }
      end
      
      Formatador.display_table(data)
    end

    
    private

    def group_issues_by_assigner(issues)
      issues = issues.sort_by { |issue| - issue["status"]["id"] }
      group_issues = issues.group_by{|issue|issue["assigner"]["name"] if issue["assigner"]}
      group_issues.sort_by do |name, issues|
        - progress_rate(issues).sub('%','').to_i
      end
    end
    
    def progress_rate(issues)
      total_count = issues.count
      completed_count = issues.count{|issue|issue["status"]["id"] == 4}
      "%d%" % (completed_count.to_f / total_count * 100)
    end

    def completed_count_per_total_count(issues)
      total_count = issues.count
      completed_count = issues.count{|issue|issue["status"]["id"] == 4}
      "%d/%d" % [completed_count, total_count]
    end

    def progress_bar(issues)
      issues.inject('') do |ret, issue|
        ret << 
          case issue["status"]["id"]
          when 1
            "|".red
          when 2
            "|".yellow
          when 3
            "|".green
          when 4
            "|".blue
          end
      end
      
    end


    
  end # Command < Thor
end # BacklogApi
