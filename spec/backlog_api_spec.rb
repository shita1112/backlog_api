# -*- coding: utf-8 -*-
require_relative 'spec_helper'

# とっぷもじゅーる
describe BacklogApi do
  # クラス
  describe Client do


    # ###################################
    # # 初心者だし、コレをテンプレートにしていきましょう
    # ###################################
    # # 1. ExampleGroup メソッド
    # describe '#get_timeline' do
    #   # 事前準備
    #   before { @client = Client.new }

    #   # 2. Example
    #   it 'タイムラインを取得すること' do
    #     # 3. Expectation
    #     expect(@client.get_timeline).to be_a(Array)
    #   end
    # end
    # ###################################


    describe '#get_timeline' do
      # 事前準備
      subject { Client.new }

      # 2. Example
      it 'タイムラインを取得すること' do
        # 3. Expectation
        response = subject.get_timeline
        expect(response).to be_a(Array)
      end
    end







    
  end

  describe Const do
  end
  describe Command do
  end


end



