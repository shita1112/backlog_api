# -*- coding: utf-8 -*-
require 'spec_helper'

#ENV['RACK_ENV'] = 'test'

# ドライバ
# Capybara.register_driver :my_selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :firefox)
# end
# Capybara.default_driver = :my_selenium
# Capybara.javascript_driver = :my_selenium
Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit

include Capybara::DSL

# Sinatraアプリ起動
def setup
  # classicスタイルの場合、Sinatra::Application.newがサーバインスタンスになる
  Capybara.app = Sinatra::Application.new
end

describe '/test' do
  before { setup }

  it do
    visit '/test'
    expect(page).to have_content('test')
  end
end


describe '/' do
  before { setup }

  it do
    pending
    visit '/'    
  end
end

