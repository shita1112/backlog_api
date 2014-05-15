# -*- coding: utf-8 -*-
require_relative '../../spec_helper' # このファイルからの相対パス

module BacklogApi

  WebMock.allow_net_connect! # 指定URL以外のアクセスはok by webmock

  describe Client do
    
    subject { Client.new }
    
    describe '#get_timeline' do
      it { expect(subject.get_timeline).to be_a(Array) }
    end

    
    BacklogApi::API_METHODS.keys do |k, v|
      describe '#%s' % k.underscore do
        it do
          required
          opt
          response subject.send k.underscore
          expect().to be_a(Array)
        end
      end
    end
    
  













    # ====================================================
    # 後回し
    # ====================================================



    # # init do
    # describe '#init do
    #   it do
    #     expect(subject).to be_an_instance_of Client # instance_of(直接のインスタンス)
    #   end
    # end


    # # TODO:
    # # APIのアクセス
    # API_METHODS.each do |k, v|
    #   # 1メソッド
    #   describe ('#%s' % k).underscore do
    #     # TODO: 
    #     it do
    #       pending
    #       expect(subject.get_timeline).to be_a v[:return_type].constantize
    #     end
    #   end # describe
    # end 
    











    # ######################################################################
    # # private
    # ######################################################################
    # describe '#call' do
    #   it do
    #     response = subject.send :call, "getTimeline"
    #     expect(response).to be_a Array
    #   end
    # end

    # # TODO: だめ
    # describe '#login_from_netrc' do
    #   it do
    #     subject.send :login_from_netrc
    #     expect(subject.user).not_to be_nil # nil?
    #   end
    # end

    # # TODO: これもだめ。めちゃくちゃ
    # describe '#login_from_environment_variables' do      
    #   context '環境変数がセットされている場合は' do
    #     it do
    #       ENV["BACKLOG_USER"], ENV["BACKLOG_PASSWORD"],ENV["BACKLOG_SPACE"] = "a", "b", "c"
    #       subject = Client.new
    #       subject.send :login_from_environment_variables
    #       expect(subject.user).not_to be_nil
    #     end  
    #   end
    #   context '環境変数がセットされていない場合は' do
    #     it do
    #       ENV["BACKLOG_USER"], ENV["BACKLOG_PASSWORD"],ENV["BACKLOG_SPACE"] = nil, nil, nil
    #       subject = Client.new
    #       subject.send :login_from_environment_variables
    #       expect(subject.user).to be_nil
    #     end  
    #   end
    # end

    # describe '#login_from_args' do
    #   it do
    #     subject.send :login_from_args, {user: "a", password: "b", space: "c"}
    #     expect(subject.user).to eq "a" # ==
    #     expect(subject.password).to eq "b" 
    #     expect(subject.space).to eq "c"
    #   end
    # end







    
    
    
  end # describe
end # module
