# -*- coding: utf-8 -*-
require_relative '../../spec_helper'

PROJECT_ID = ENV['BACKLOG_PROJECTID2'].to_i

module BacklogApi
  describe Command do
    subject { Command.new }

    # =============================
    # private
    # =============================
    describe '#group_issues_by_assigner' do

      
      let(:issues) do
        # :TODO mock使うように修正
        [
          {
            "status"=>{"id"=>4, "name"=>"完了"},
            "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"},
          },
          {
            "status"=>{"id"=>4, "name"=>"完了"},
            "assigner"=>{"id"=>100000001, "name"=>"山田　花子"},
          },
        ]
      end
      
      it do
        grouped_issues = subject.send :group_issues_by_assigner, issues
        expect(grouped_issues.tapp).to have(2).members
        expect(grouped_issues.keys).to eq ["山田　太郎", "山田　花子"]
      end
    end

    
    describe '#progress_rate' do
      context '全て完了している時' do
        it do
          issues = 
            [{"status"=>{"id"=>4, "name"=>"完了"},
              "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}}]
          
          progress_rate = subject.send :progress_rate, issues
          expect(progress_rate).to eq "100%"        
        end
      end
      context '1/2完了している時' do
        it do
          issues = 
            [{"status"=>{"id"=>4, "name"=>"完了"},
              "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}},
            {"status"=>{"id"=>1, "name"=>"作業中"},
              "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}}]
          
          progress_rate = subject.send :progress_rate, issues
          expect(progress_rate).to eq "50%"
        end
      end
    end

    describe '#completed_count_per_total_count' do
      context '全て完了している時' do
        it do
          issues = 
            [{"status"=>{"id"=>4, "name"=>"完了"},
              "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}}]
          
          progress_rate = subject.send :completed_count_per_total_count, issues
          expect(progress_rate).to eq "1/1"        
        end
      end
      context '1/2完了している時' do
        it do
          issues = 
            [{"status"=>{"id"=>4, "name"=>"完了"},
              "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}},
            {"status"=>{"id"=>1, "name"=>"作業中"},
              "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}}]
          
          progress_rate = subject.send :completed_count_per_total_count, issues
          expect(progress_rate).to eq "1/2"
        end
      end      
    end

    describe '#progress_bar' do
      it do
        issues = 
          [{"status"=>{"id"=>4, "name"=>"完了"},
            "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}},
          {"status"=>{"id"=>3, "name"=>"処理済み"},
            "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}},
          {"status"=>{"id"=>2, "name"=>"処理中"},
            "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}},
          {"status"=>{"id"=>1, "name"=>"未対応"},
            "assigner"=>{"id"=>100000000, "name"=>"山田　太郎"}}
        ]
        progress_bar = subject.send :progress_bar, issues
        expect(progress_bar).to eq("|".blue + "|".green + "|".yellow + "|".red )
      end
    end

  end
end
