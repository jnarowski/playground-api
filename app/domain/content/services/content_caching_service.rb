class Content::Services::ContentCachingService
	def cache_daily_content!(user_id)
		cache_goodreads!(user_id)
		cache_pocket(user_id)
	end

	def cache_goodreads!(user_id)
	end

	def cache_pocket!(user_id)
	end
end