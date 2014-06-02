# -*- coding: utf-8 -*-
require 'backlog_api'
require "haml"
require 'sinatra'
require 'sinatra/reloader'

# 何度も読み込まれて舞う
PROJECT_ID = ENV['BACKLOG_PROJECTID2'].to_i
ASSIGENER_ID = ENV['BACKLOG_USERID'].to_i


# CLIENT = BacklogApi::Client.new
# トップレベルには定義できないのでここにビューヘルパーとか追加してね
helpers do
  def select_tag(name, selected_id, opt)
    options = opt.map do |k,v|
      "<option value='#{k}' #{selected_id == k.to_i ? %{selected} : ''} > #{v}</option>"
    end.join

    <<-"EOS"
    <select name='#{name}'>
      #{options}
    </select>
    EOS
  end
  
  def status_select_tag(issue)
    select_tag("status[#{issue["key"]}]", issue["status"]["id"],
      '1' => '未対応',
      '2' => '処理中',
      '3' => '処理済み',
      '4' => '完了',
      )
  end
  
end


# アクションみたいなの
get '/' do
  # "views/index.erb"をrender。○しかし今回は"@@ index" の部分をrenderする

  @issues = BacklogApi::Client.new.find_issue(
    projectId: PROJECT_ID,
    assignerId: ASSIGENER_ID,
    sort: :STATUS, # ステータスでソート
    order: true, # 昇順
    ).tapp(&:count)
  
  erb :index
end

post '/issues' do
  BacklogApi::Client.new.create_issue(
    projectId: PROJECT_ID,
    assignerId: ASSIGENER_ID,
    summary: params[:summary],
    issueTypeId: 1074130811, # タスク
    )
  redirect '/'
end


post '/update_issues' do
  params["status"].each do |k, v|
    begin
      BacklogApi::Client.new.switch_status(
        key: k,
        statusId: v.to_i,
        )
      puts "update"
    rescue
      # TODO: 警告とかね
      puts "do nothing"
    end
  end
  redirect '/'  
end


get '/test' do
  "test"
end





# __END__: コレ以降がインラインテンプレートになる
__END__

# @@index: "views/index.erb"と同義っぽい
@@index

<html>
  <body>
    <h1>課題追加</h1>
      <form action='/issues' method='post'>
        <input type='text_field' value='' name='summary'>
        <input type='submit' value='さぁ、課題を追加するのです！'>
      </form>

    <h1>課題更新</h1>
    <form action='/update_issues' method='post'>
    <table>
      <tr>
        <th>件名</th>
        <th>ステータス</th>
        <th>リンク</th>
      </tr>
      <% @issues.each do |issue| %>
      <tr>
        <td><%= issue["summary"] %></td>
        <td><%= status_select_tag issue %></td>
        <td><a href='<%= issue["url"] %>'>おいきなさい!!</a></td>
      </tr>
      <% end %>
    </table>
    <input type='submit' value='課題の一括更新です！'>
    </form>
	<body>
</html>

