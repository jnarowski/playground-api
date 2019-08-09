# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Growthscore::Providers::SemRushProvider do
  let(:success_response_body) {
    [{:domain=>"singlegrain.com", :rank=>"34451", :organic_keywords=>"66159", :organic_traffic=>"59978", :organic_cost=>"361992", :adwords_keywords=>"17", :adwords_traffic=>"96", :adwords_cost=>"997"}]
  }

  subject do
    Growthscore::Providers::SemRushProvider.new
  end

  describe '#fetch_domain' do
  end
end
