# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Growthscore::Services::GrowthScoreService do
  subject do
    IocContainer[:growth_score_service]
  end

  let(:mock_response_factory) {
    MockResponseFactory.new
  }

  describe '#generate' do
    before do
      stub_request(:get, /clearbit.com/).to_return(
        status: 200,
        body: mock_response_factory.clearbit.singlegrain
      )
      stub_request(:get, /googleapis.com/).to_return(
        status: 200,
        body: mock_response_factory.page_speed_insights.singlegrain,
      )
      stub_request(:get, /api.adbeat.com/).to_return(
        status: 200,
        body: mock_response_factory.adbeat.singlegrain,
      )
      allow_any_instance_of(Growthscore::Providers::SemRushProvider).to(
        receive(:fetch_for_growth_score).and_return(mock_response_factory.sem_rush.singlegrain)
      )
    end

    it 'should successfully generate a report' do
      report = subject.generate('https://www.singlegrain.com')

      metrics = report.metrics
      raw_data = report.raw_data.with_indifferent_access

      expect(report.id).to be_present
      expect(report.domain).to eq('singlegrain.com')
      expect(report.metrics).to be_present
      expect(raw_data).to be_present
      expect(raw_data[:adbeat][:apiUnits]).to be_present
      expect(raw_data[:clearbit][:tech].size).to be > 0
      expect(raw_data[:sem_rush].first[:adwords_cost]).to be_present
      expect(raw_data[:ssl][:valid]).to be_falsy
      expect(raw_data[:page_speed_insights][:overall_category]).to eq('SLOW')
    end
  end

  describe '#generate_analytics_tags_metrics' do
    it 'should score a perfect 10 if it has both google_analytics and segment' do
      data = {
        clearbit: {
          tech: ['google_analytics', 'segment']
        }
      }

      actual = subject.generate_analytics_tags_metrics(data)
      expect(actual[:score]).to eq(10)
    end
  end

  describe '#generate_website_performance_metrics' do
    it 'should score a perfect 20 if it has both bing and facebook advertising' do
      data = {
        page_speed_insights: {
          overall_category: 'SLOW',
          first_contentful_paint_ms: 'FAST'
        }
      }

      actual = subject.generate_website_performance_metrics(data)
      expect(actual[:score]).to eq(10)
    end
  end

  describe '#generate_security_metrics' do
    it 'should score a perfect 20 if it has SSL' do
      data = {
        ssl: {
          cert: OpenStruct.new,
          valid: true
        }
      }

      actual = subject.generate_security_metrics(data)
      expect(actual[:score]).to eq(20)
    end
  end

  describe '#generate_seo_metrics' do
    it 'should score a perfect 20 if it has ' do
      data = {
        sem_rush: [{
          domain: 'singlegrain.com',
          rank: 1,
          organic_keywords: 100_000_000,
        }]
      }

      actual = subject.generate_seo_metrics(data)
      expect(actual[:score]).to eq(20)
    end
  end
end
