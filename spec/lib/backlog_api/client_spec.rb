# -*- coding: utf-8 -*-
require_relative '../spec_helper' # このファイルからの相対パス

module BacklogApi
  # 1. ExampleGroup describe クラス
  describe Client do

    # 事前準備。主にオブジェクトの生成。ここでしちゃってもok
    # before{ @subject = Client.new } # +αの場合
    # let(:subject){ Client.new} # 複数の場合
    subject { Client.new } # 1つの場合


        
    ###################################
    # とりあえずコレ(1メソッドのテスト)を一単位として考える
    ##################################
    # 1. ExampleGroup describe メソッド
    describe '#get_timeline' do
      # 2. Example
      it 'ハッシュが返ること' do
        # 3. Expectation
        # subject.get_timeline.class should == Hash
        # expect(actual).to be_a(expected)
        # be_an_instance_of: a_instance_of?
        # expect(subject.get_timeline).to be_an_instance_of(Hash)
        expect(subject.get_timeline).to be_a(Array)
      end

      # TODO: なんかもっとましなの
      it 'ハッシュのキーに:idを持つこと' do
        # subject.get_timeline.has_key?(:id).should be_true
        subject.get_timeline.should have_key(:id)
      end
    end
    ###################################








    # initialize
    describe '#initialize' do
      it 'Clientのインスタンスを生成すること' do
        expect(subject) be_an_instance_of Client # instance_of(直接のインスタンス)
      end
    end


    # TODO:
    # APIのアクセス
    API_METHODS.each do |k, v|
      # 1メソッド
      describe '#%d' % k.underscore do
        # TODO: 
        it "#{v[:return_type]}を返すこと" do
          pending
          expect(subject.get_timeline) be_a v[:return_type].constantize
        end
      end # describe
    end 
    






    ######################################################################
    # private
    ######################################################################
    describe '#call' do
      it 'BacklogのAPIを叩くこと' do
        response = subject.send :call, "getTimeline"
        expect(response).to be_a Array
      end
    end

    # TODO: だめ
    describe '#login_from_netrc' do
      it 'ログイン情報として.netrcの内容を利用すること' do
        subject.send :login_from_netrc
        expect(subject.user).not_to be_nil # nil?
      end
    end

    # TODO: これもだめ。めちゃくちゃ
    describe '#login_from_environment_variables' do      
      context '環境変数がセットされている場合は' do
        it 'ログイン情報として環境変数の内容を利用すること' do
          ENV["BACKLOG_USER"], ENV["BACKLOG_PASSWORD"],ENV["BACKLOG_SPACE"] = "a", "b", "c"
          subject = Client.new
          subject.send :login_from_environment_variables
          expect(subject.get_timeline).to be_a(Array)
        end  
      end
      context '環境変数がセットされていない場合は' do
        it 'ログイン情報として環境変数の内容を利用しない' do
          ENV["BACKLOG_USER"], ENV["BACKLOG_PASSWORD"],ENV["BACKLOG_SPACE"] = nil, nil, nil
          subject = Client.new
          subject.send :login_from_environment_variables
          expect(subject.user).not_to nil
        end  
      end
    end

    describe '#login_from_args' do
      it 'ログイン情報として引数を利用すること' do
        subject.send :login_from_args, {user: "a", password: "b", space: "c"}
        expect(subject.user).to eq "a" # ==
        expect(subject.password).to eq "b" 
        expect(subject.space).to eq "c"
      end
    end

    

    
    
    
    
    
    
  end # describe
end # module
