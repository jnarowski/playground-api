class External::PocketClient
	# https://getpocket.com/developer/docs/v3/retrieve
	def list(token:, offset: 0)
		response = Faraday.get("https://getpocket.com/v3/get",
			consumer_key: ENV.fetch('POCKET_APP_KEY'),
			access_token: token,
			offset: offset
		)
		
		JSON.parse response.body
	end
end