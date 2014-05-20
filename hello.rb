# -*- coding: utf-8 -*-
require 'sinatra'
require 'sinatra/reloader'

helpers do
  def double(str)
    str * 2
  end
end




get '/shibata' do
  "shibata!"
end

get "/hello/:name" do
  "hello #{double params[:name]}"
end


# アクション
get '/' do
  # "views/index.erb"をrender。○しかし今回は"@@ index" の部分をrenderする
  @hoge = "hoge!"
  erb :index
end

# __END__: コレ以降がインラインテンプレートになる
__END__

# @@index: "views/index.erb"と同義っぽい
@@index
<html>
  <body>
    <h1>コレはインラインビューだ！</h1>
    <%= double @hoge %>
	<body>
</html>
 
