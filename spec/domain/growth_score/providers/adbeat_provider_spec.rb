# frozen_string_literal: true

require 'rails_helper'

RESPONSE_SUCCESS = "{\"statusCode\":200,\"numHits\":4,\"hits\":[{\"countryId\":\"us\",\"lastSeen\":\"2017-12-22\",\"publisherId\":\"walmart.com\",\"adTypeImpactsNew\":{\"text\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":2764}},\"adCountsUnique\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"adSizeImpactsNew\":{},\"networkId\":\"google-search\",\"hasChannels\":false,\"daysSeen\":1,\"platformId\":\"android\",\"adSizeImpacts\":{},\"adTrends\":{\"30\":0,\"90\":0},\"categoryIds\":[],\"publisherCountsUnique\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"isChannel\":false,\"adImpacts\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":2765},\"dmaImpacts\":{\"(no DMA specified)\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":2764}},\"adTypeImpacts\":{\"text\":2764},\"firstSeen\":\"2017-12-22\"},{\"countryId\":\"us\",\"lastSeen\":\"2017-12-21\",\"publisherId\":\"walmart.com\",\"adTypeImpactsNew\":{\"text\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1445}},\"adCountsUnique\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"adSizeImpactsNew\":{},\"networkId\":\"google-search\",\"hasChannels\":false,\"daysSeen\":1,\"platformId\":\"iPhone\",\"adSizeImpacts\":{},\"adTrends\":{\"30\":0,\"90\":0},\"categoryIds\":[],\"publisherCountsUnique\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"isChannel\":false,\"adImpacts\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1445},\"dmaImpacts\":{\"Portland, OR\":{\"365\":0,\"180\":0,\"30\":0,\"90\":0,\"730\":1445}},\"adTypeImpacts\":{\"text\":1445},\"firstSeen\":\"2017-12-21\"},{\"countryId\":\"us\",\"lastSeen\":\"2018-08-05\",\"publisherId\":\"businessinsider.com\",\"adTypeImpactsNew\":{\"textimg\":{\"365\":461,\"180\":0,\"30\":0,\"90\":0,\"730\":461}},\"adCountsUnique\":{\"365\":1,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"adSizeImpactsNew\":{\"other\":{\"365\":461,\"180\":0,\"30\":0,\"90\":0,\"730\":461}},\"networkId\":\"google\",\"hasChannels\":false,\"daysSeen\":1,\"platformId\":\"iPad\",\"adSizeImpacts\":{\"other\":461},\"adTrends\":{\"30\":0,\"90\":0},\"categoryIds\":[],\"publisherCountsUnique\":{\"365\":1,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"isChannel\":false,\"adImpacts\":{\"365\":461,\"180\":0,\"30\":0,\"90\":0,\"730\":461},\"dmaImpacts\":{\"Los Angeles\":{\"365\":461,\"180\":0,\"30\":0,\"90\":0,\"730\":461}},\"adTypeImpacts\":{\"textimg\":461},\"firstSeen\":\"2018-08-05\"},{\"countryId\":\"in\",\"lastSeen\":\"2018-08-06\",\"publisherId\":\"business2community.com\",\"adTypeImpactsNew\":{\"text\":{\"365\":11,\"180\":0,\"30\":0,\"90\":0,\"730\":11}},\"adCountsUnique\":{\"365\":1,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"adSizeImpactsNew\":{},\"networkId\":\"google\",\"hasChannels\":false,\"daysSeen\":1,\"platformId\":\"desktop\",\"adSizeImpacts\":{},\"adTrends\":{\"30\":0,\"90\":0},\"categoryIds\":[],\"publisherCountsUnique\":{\"365\":1,\"180\":0,\"30\":0,\"90\":0,\"730\":1},\"isChannel\":false,\"adImpacts\":{\"365\":11,\"180\":0,\"30\":0,\"90\":0,\"730\":11},\"dmaImpacts\":{\"(no DMA specified)\":{\"365\":11,\"180\":0,\"30\":0,\"90\":0,\"730\":11}},\"adTypeImpacts\":{\"text\":11},\"firstSeen\":\"2018-08-06\"}],\"apiUnits\":120,\"statusMsg\":\"successful advertiserMetrics request\",\"requestParameters\":{\"advertiserId\":\"singlegrain.com\"},\"handler\":\"advertiserMetrics\"}\n"

RSpec.describe Growthscore::Providers::AdbeatProvider do
  subject do
    IocContainer[:adbeat_provider]
  end

  describe '#fetch_advertiser_metrics' do
    before do
      stub_request(:get, /api.adbeat.com/).to_return(:status => 200, :body => RESPONSE_SUCCESS, :headers => {})
    end

    it 'should return the domain information' do
      results = subject.fetch_advertiser_metrics('singlegrain.com')
    end
  end
end
