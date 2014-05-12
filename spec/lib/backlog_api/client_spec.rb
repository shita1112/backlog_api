# -*- coding: utf-8 -*-
require_relative '../spec_helper' # このファイルからの相対パス

module BacklogApi
  # 1. ExampleGroup describe クラス
  describe Client do

    ###################################
    # とりあえずコレ(1メソッドのテスト)を一単位として考える
    ###################################
    # 1. ExampleGroup describe メソッド
    describe '#get_timeline' do
      # 事前準備。主にオブジェクトの生成
      # before{ @subject = Client.new } # +αの場合
      # let(:subject){ Client.new} # 複数の場合
      subject { Client.new } # 1つの場合

      # 2. Example
      it 'ハッシュが返ること' do
        # 3. Expectation
        # subject.get_timeline.class should == Hash
        # expect(actual).to be_a(expected)
        # be_an_instance_of: a_instance_of?
        expect(subject.get_timeline).to be_an_instance_of(Hash)
      end

      # TODO: なんかもっといいの
      it 'ハッシュのキーに:idを持つこと' do
        # subject.get_timeline.has_key?(:id).should be_true
        subject.get_timeline.should have_key(:id)
      end
    end
    ###################################



    
  end # describe
end # module
