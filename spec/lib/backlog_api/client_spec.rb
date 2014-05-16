# -*- coding: utf-8 -*-
require_relative '../../spec_helper' # このファイルからの相対パス

module BacklogApi

  WebMock.allow_net_connect! # 指定URL以外のアクセスはok by webmock

  describe Client do
    
    subject { Client.new }
    let(:url) { 'https://%s%s' % [subject.host, Client::PATH]} # 使いまわし
    let(:opt) { {record: :new_episodes} }
    let!(:name) {example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")} # 毎回let

    
    describe '#get_projects' do
      it do
        VCR.use_cassette(name, opt) do # vcrのキャッシュ
          expect(subject.get_projects).to be_a(Array)
        end
      end
    end

    describe "#get_project" do
      it do
        # request_body = '<data projectId="projectId" />'
        # response_body = {
        #   "use_parent_child_issue" => true,
        #   "id" => 1,
        #   "text_formatting_rule" => "backlog",
        #   "archived" => false,
        #   "name" => "name",
        #   "url" => "url",
        #   "key" => "key"}          
        # WebMock
        #   .stub_request(:post, url) # url
        #   .with(body: request_body, content_type: 'application/xml') # request
        #   .to_return(status: 200, body: response_body, headers: {}) # response
        # expect(subject.get_project("projectId" => "projectID")).to be_a(Hash) # webmock
        
        VCR.use_cassette(name, opt) do # vcrのキャッシュ
          expect(subject.get_project("2014YC")).to be_a(Hash) # webmock
        end
      end
    end

    # describe "#get_components" do
    #   it do
    #             pending
    #     request_body = 1
    #     response_body = [
    #       {"id"=>2, "name"=>"name1"},
    #       {"id"=>3, "name"=>"name2"}
    #     ]
    #     WebMock
    #       .stub_request(:post, url) # url
    #       .with(body: request_body, headers: {}) # request
    #       .to_return(status: 200, body: response_body, headers: {}) # response
    #     expect(subject.get_components(1)).to be_a(Array) # webmock
    #   end
    # end





    # getComponents:
    #   type: scalar
    #   required: [projectId]
    #   desc: 'プロジェクトのカテゴリを返します。'
    # getVersions:
    #   type: scalar
#   required: [projectId]
#   desc: 'プロジェクトの発生バージョン/マイルストーンを返します。'
# getUsers:
#   type: scalar
#   required: [projectId]
#   desc: 'プロジェクトの参加メンバーを返します。'
# getIssueTypes:
#   type: scalar
#   required: [projectId]
#   desc: 'プロジェクトの種別を返します。'
# getIssue:
#   type: scalar
#   required: [issueKey]
#   desc: '課題キーを指定して、課題を取得します。'
# getIssue:
#   type: scalar
#   required: [issueId]
#   desc: '課題IDを指定して、課題を取得します。'
# getComments:
#   type: scalar
#   required: [issueId]
#   desc: '課題のコメントを返します。'
# countIssue:
#   type: struct
#   required: [projectId]
#   desc: '指定した条件に該当する課題件数を返します。'
# findIssue:
#   type: struct
#   required: [projectId]
#   desc: '指定した条件に該当する課題を返します。'
# createIssue:
#   type: struct
#   required: [projectId, summary]
#   desc: '課題を追加します。'
# updateIssue:
#   type: struct
#   required: [key]
#   desc: '課題を更新します。'
# switchStatus:
#   type: struct
#   required: [key, statusId]
#   desc: '課題の状態を変更します。'
# addComment:
#   type: struct
#   required: [key, content]
#   desc: '課題にコメントを追加します。'
# addIssueType:
#   type: struct
#   required: [project_id, name, color]
#   desc: 'プロジェクトの課題種別を追加します。'
# updateIssueType:
#   type: struct
#   required: [id, name, color]
#   desc: 'プロジェクトの課題種別を更新します。'
# deleteIssueType:
#   type: struct
#   required: [id, substitute_id]
#   desc: 'プロジェクトの課題種別を削除します。'
# addVersion:
#   type: struct
#   required: [project_id, name]
#   desc: 'プロジェクトの発生バージョン/マイルストーンを追加します。'
# updateVersion:
#   type: struct
#   required: [id, name]
#   desc: 'プロジェクトの発生バージョン/マイルストーンを更新します。'
# deleteVersion:
#   type: struct
#   required: [id]
#   desc: 'ロジェクトの発生バージョン/マイルストーンを削除します。'
# addComponent:
#   type: struct
#   required: [project_id, name]
#   desc: 'プロジェクトのカテゴリを追加します。追加に成功した場合は、'
# updateComponent:
#   type: struct
#   required: [id, name]
#   desc: 'プロジェクトのカテゴリを更新します。'
# deleteComponent:
#   type: struct
#   required: [id]
#   desc: 'プロジェクトのカテゴリを削除します。'
# getTimeline:
#   type: struct
#   required: []
#   desc: '参加プロジェクトすべての課題の更新情報を配列で返します(最大50件)。'
# getProjectSummary:
#   type: scalar
#   required: [projectId]
#   desc: 'プロジェクト状況を取得します。'
# getProjectSummaries:
#   type: null
#   required: []
#   desc: '全ての参加プロジェクト状況を取得します。'
# getUser:
#   type: scalar
#   required: [id]
#   desc: 'ユーザID(数値またはログインID)を指定して、ユーザを取得します。'
# getUserIcon:
#   type: scalar
#   required: [id]
#   desc: 'ユーザID(数値またはログインID)を指定して、ユーザのアイコン画像を取得します。'
# getActivityTypes:
#   type: null
#   required: []
#   desc: '課題の更新情報の種別一覧を取得します。'
# getStatuses:
#   type: null
#   required: []
#   desc: '課題の状態一覧を取得します。'
# getResolutions:
#   type: null
#   required: []
#   desc: '課題の完了理由一覧を取得します。'
# getPriorities:
#   type: null
#   required: []
#   desc: '課題の優先度一覧を取得します。'
# getCustomFields:
#   type: struct
#   required: [projectId]
#   desc: 'プロジェクトに登録してあるカスタム属性の情報を取得します。'
# getChildIssues:
#   type: struct
#   required: [parent_issue_id]
#   desc: '指定した親課題のIDの子課題を返します。'

    
  













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
