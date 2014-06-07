# -*- coding: utf-8 -*-
lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "simplecov"
require "coveralls"

# この行以降にrequireしたものが対象になる
# simplecov, coderails の2通りの書式でレポートを得る
# 毎回だと鬱陶しいのでCOV=trueの時だけ
if ENV["COV"] == 'true'
  Coveralls.wear! 
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start
end


require 'backlog_api' # require all
require 'bundler/setup' # look at Gemfile.lock
require 'webmock'
require 'vcr'

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'capybara/poltergeist'         
require 'capybara-webkit'
require 'launchy'


 
# RSpecの設定
RSpec.configure do |config|
  # VCRの設定
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/vcr_cassettes' # VCRで記録するYAMLファイルのパス
    c.hook_into :webmock # webmockをhookとする
    c.allow_http_connections_when_no_cassette = true  # VCRブロック外のHTTP通信は許可する
  end

  # VCR.use_cassetteを使わなくて済む。Specのdescribeを元にVCRのファイル名を生成する。"spec/lib/backlog_apiのClient#get_timeline"であれば"spec/vcr_cassettes/backlog_api/client_get_timeline.yml"を作成
  # config.around(:each) do |example| # aroundフック
  #   options = example.metadata[:vcr] || {}
  #   if options[:record] == :skip 
  #     VCR.turned_off(&example)
  #   else
  #     name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_") # descからファイル名を取得
  #     VCR.use_cassette(name, options, &example) # コレで囲むよー
  #   end
  # end

  def app
    Sinatra::Application
  end

end


