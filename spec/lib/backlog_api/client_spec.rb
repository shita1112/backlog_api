# -*- coding: utf-8 -*-
require_relative '../../spec_helper' # このファイルからの相対パス

module BacklogApi

  WebMock.allow_net_connect! # 指定URL以外のアクセスはok by webmock

  describe Client do
    
    subject { Client.new }

    # letはitの度に生成されるよ。letは遅延評価でlet!は即評価だよ
    let(:url) { 'https://%s%s' % [subject.host, Client::PATH]} 
    
    # for vcr
    let(:opt) { {record: :new_episodes} }
    let(:path) {example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")}

    # for backlog_api's key
    let(:project_key) {ENV['BACKLOG_PROJECTKEY'] }
    let(:project_id) {ENV['BACKLOG_PROJECTID'].to_i}
    let(:issue_key) {ENV['BACKLOG_ISSUEKEY']} 
    let(:issue_id) {ENV['BACKLOG_ISSUEID'].to_i} 
    let(:summary) {ENV['BACKLOG_SUMMARY']} 
    let(:key) {ENV['BACKLOG_KEY']} 
    let(:status_id) {ENV['BACKLOG_STATUSID'].to_i} 
    let(:name) {ENV['BACKLOG_NAME']} 
    let(:color) {ENV['BACKLOG_COLOR']} 
    let(:substitute_id) {ENV['BACKLOG_SUBSTITUTE_ID'].to_i} 
    let(:id) {ENV['BACKLOG_ID'].to_i} 
    let(:parent_issue_id) {ENV['BACKLOG_PARENTISSUEID'].to_i} 
    let(:project_name) {ENV['BACKLOG_PROJECTNAME']} 
    let(:category_name) {ENV['BACKLOG_CATEGORYNAME']} 
    let(:project_id2) {ENV['BACKLOG_PROJECTID2'].to_i} 
    let(:user_id) {ENV['BACKLOG_USERID'].to_i} 

    METHOD = 'backlog.%s'

    describe '#get_projects' do
      it do
        VCR.use_cassette(path, opt) do # vcrのキャッシュ
          expect(subject.get_projects).to be_a(Array)
        end
      end
    end

    describe '#get_project' do
      it do
        VCR.use_cassette(path, opt) do # vcrのキャッシュ
          expect(subject.get_project(project_key)).to be_a(Hash)
        end
      end
    end

    describe '#get_components' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_components(project_id)).to be_a(Array)
        end
      end
    end

    describe '#get_versions' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_versions(project_id)).to be_a(Array)
        end
      end
    end

    describe '#get_users' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_users(project_id)).to be_a(Array)
        end
      end
    end

    describe '#get_issue_types' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_issue_types(project_id)).to be_a(Array)
        end
      end
    end

    describe '#get_issue' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_issue(project_id)).to be_a(Hash)
        end
      end
    end

    describe '#get_users' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_users(project_id)).to be_a(Array)
        end
      end
    end

    describe '#get_issue' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_issue(issue_id)).to be_a(Hash)
        end
      end
    end

    describe '#get_comments' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_comments(issue_id)).to be_a(Array)
        end
      end
    end

    describe '#count_issue' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.count_issue(projectId: project_id)).to be_a(Integer)
        end
      end
    end

    describe '#find_issue' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.find_issue(projectId: project_id)).to be_a(Array)
        end
      end
    end

    describe '#create_issue' do
      it do
        VCR.use_cassette(path, opt) do
          expect(
            subject.create_issue(
              projectId: project_id,
              summary: summary,
              )
            ).to be_a(Hash)
        end
      end
    end

    describe '#update_issue' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.update_issue(key: key)).to be_a(Hash)
        end
      end
    end

    describe '#switch_status' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.switch_status(key: key, statusId: status_id)).to be_a(Hash)
        end
      end
    end

    describe '#add_issue_type' do
      it do
        VCR.use_cassette(path, opt) do
          expect(
            subject.add_issue_type(
              project_id: project_id,
              name: name,
              color: color, 
              )
            ).to be_a(Hash)
        end
      end
    end

    describe '#update_issue_type' do
      it do
        VCR.use_cassette(path, opt) do
          expect(
            subject.update_issue_type(
              id: id,
              name: name,
              color: color, 
              )              
            ).to be_a(Hash)
        end
      end
    end


    describe '#delete_issue_type' do
      it do
        VCR.use_cassette(path, opt) do
          expect(
            subject.delete_issue_type(
              id: id,
              )              
            ).to be_a(Hash)
        end
      end
    end


    describe '#add_version' do
      it do
        VCR.use_cassette(path, opt) do
          expect(
            subject.add_version(
              project_id: project_id,
              name: project_name
              )
            ).to be_a(Hash)
        end
      end
    end


    describe '#update_version' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.update_version(id: project_id, name: project_name)).to be_a(Hash)
        end
      end
    end

    describe '#get_timeline' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_timeline).to be_a(Array)
        end
      end
    end


    describe '#get_project_summary' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_project_summary(project_id)).to be_a(Hash)
        end
      end
    end

    describe '#get_statuses' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_statuses).to be_a(Array)
        end
      end
    end

    describe '#get_resolutions' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_resolutions).to be_a(Array)
        end
      end
    end

    describe '#get_priorities' do
      it do
        VCR.use_cassette(path, opt) do
          expect(subject.get_priorities).to be_a(Array)
        end
      end
    end

 


    # describe "#get_project" do
    #   it do
    #     request_body = '<data projectId="projectId" />'
    #     response_body = {
    #       "use_parent_child_issue" => true,
    #       "id" => 1,
    #       "text_formatting_rule" => "backlog",
    #       "archived" => false,
    #       "name" => "name",
    #       "url" => "url",
    #       "key" => "key"}          
    #     WebMock
    #       .stub_request(:post, url) # url
    #       .with(body: request_body, content_type: 'application/xml') # request
    #       .to_return(status: 200, body: response_body, headers: {}) # response
    #     expect(subject.get_project("projectId" => "projectID")).to be_a(Hash) # webmock
        
    #     expect(subject.get_project("2014YC")).to be_a(Hash) # webmock
    #   end
    # end

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

    
    describe '#new' do
      it do
        expect(subject).to be_an_instance_of Client # instance_of(直接のインスタンス)
      end
    end


    # ====================================================
    # private
    # ====================================================
    describe '#call' do
      it do
        VCR.use_cassette(path, opt) do
          response = subject.send :call, METHOD % "getProjects"
          expect(response).to be_a Array
        end
      end
    end

    describe '#login_from_args' do
      context '成功時' do
        it do        
          subject.send :login_from_args, {user: "a", password: "b", space: "c"}
          expect(subject.user).to eq "a" # ==
          expect(subject.password).to eq "b" 
          expect(subject.space).to eq "c"
        end
      end

      context '失敗時' do
        it do        
          subject.send :login_from_args, {user: "a", password: "b"}
          expect(subject.user).not_to eq "a" # !=
          expect(subject.password).not_to eq "b" 
          expect(subject.space).not_to eq "c"
        end
      end
    end

    # # TODO: だめだー修正だー
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








    
    
    
  end # describe
end # module
