# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Growthscore::Providers::ClearbitProvider do
  let(:success_response_body) {
    "{\n  \"id\": \"416488bb-553f-4c8a-bb14-a120722662cc\",\n  \"name\": \"Single Grain\",\n  \"legalName\": \"Single Grain LLC\",\n  \"domain\": \"singlegrain.com\",\n  \"domainAliases\": [\n\n  ],\n  \"site\": {\n    \"phoneNumbers\": [\n      \"+1 800-701-0793\",\n      \"+1 805-798-1714\"\n    ],\n    \"emailAddresses\": [\n      \"info@singlegrain.com\"\n    ]\n  },\n  \"category\": {\n    \"sector\": \"Information Technology\",\n    \"industryGroup\": \"Software & Services\",\n    \"industry\": \"Internet Software & Services\",\n    \"subIndustry\": \"Internet Software & Services\",\n    \"sicCode\": \"48\",\n    \"naicsCode\": \"51\"\n  },\n  \"tags\": [\n    \"Information Technology & Services\",\n    \"Technology\",\n    \"Internet\",\n    \"B2B\",\n    \"SAAS\"\n  ],\n  \"description\": \"Read this before you select a digital agency. We help great companies like Uber and Amazon grow. 78% of CEOs think marketers don't focus on ROI. We do.\",\n  \"foundedYear\": null,\n  \"location\": \"707 Wilshire Blvd #3630, Los Angeles, CA 90017-3501, US\",\n  \"timeZone\": \"America/Los_Angeles\",\n  \"utcOffset\": -7,\n  \"geo\": {\n    \"streetNumber\": \"707\",\n    \"streetName\": \"Wilshire Blvd\",\n    \"subPremise\": \"3630\",\n    \"city\": \"Los Angeles\",\n    \"postalCode\": \"90017\",\n    \"state\": \"California\",\n    \"stateCode\": \"CA\",\n    \"country\": \"United States\",\n    \"countryCode\": \"US\",\n    \"lat\": 34.04926,\n    \"lng\": -118.25702\n  },\n  \"logo\": \"https://logo.clearbit.com/singlegrain.com\",\n  \"facebook\": {\n    \"handle\": \"singlegrain\",\n    \"likes\": 17844\n  },\n  \"linkedin\": {\n    \"handle\": \"company/single-grain-llc\"\n  },\n  \"twitter\": {\n    \"handle\": \"singlegrain\",\n    \"id\": \"102819300\",\n    \"bio\": \"78% of CEOs Think Marketers Don't Focus On ROI. We do.\",\n    \"followers\": 11630,\n    \"following\": 7902,\n    \"location\": \"San Francisco, CA\",\n    \"site\": \"http://t.co/tyVSOGUmmZ\",\n    \"avatar\": \"https://pbs.twimg.com/profile_images/1145733782059618312/oV9kPC-7_normal.png\"\n  },\n  \"crunchbase\": {\n    \"handle\": \"organization/single-grain\"\n  },\n  \"emailProvider\": false,\n  \"type\": \"private\",\n  \"ticker\": null,\n  \"identifiers\": {\n    \"usEIN\": null\n  },\n  \"phone\": null,\n  \"metrics\": {\n    \"alexaUsRank\": 19713,\n    \"alexaGlobalRank\": 49154,\n    \"employees\": 30,\n    \"employeesRange\": \"11-50\",\n    \"marketCap\": null,\n    \"raised\": null,\n    \"annualRevenue\": null,\n    \"estimatedAnnualRevenue\": \"$1M-$10M\",\n    \"fiscalYearEnd\": null\n  },\n  \"indexedAt\": \"2019-08-01T04:21:02.560Z\",\n  \"tech\": [\n    \"google_apps\",\n    \"cloud_flare\",\n    \"drip\",\n    \"sendgrid\",\n    \"wordpress\",\n    \"google_analytics\",\n    \"mandrill\",\n    \"google_tag_manager\",\n    \"youtube\",\n    \"recaptcha\",\n    \"gravity_forms\",\n    \"facebook_advertiser\",\n    \"conversio\"\n  ],\n  \"parent\": {\n    \"domain\": null\n  },\n  \"ultimate_parent\": {\n    \"domain\": null\n  }\n}"
  }

  subject do
    Growthscore::Providers::ClearbitProvider.new
  end

  describe '#fetch_for_growth_score' do
    before do
      stub_request(:get, /clearbit.com/).to_return(:status => 200, :body => success_response_body, :headers => {})
    end

    it 'should return the domain information' do
      data = subject.fetch_for_growth_score('singlegrain.com')

      expect(data[:tech].include?('conversio')).to eq(true)
    end
  end
end
