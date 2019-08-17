class External::GoodreadsClient
	# https://www.goodreads.com/api/index#reviews.list
	# Goodreads Options
	#
	# v: 2
	# id: Goodreads id of the user
	# shelf: read, currently-reading, to-read, etc. (optional)
	# sort: title, author, cover, rating, year_pub, date_pub, date_pub_edition, date_started, date_read, date_updated, date_added, recommender, avg_rating, num_ratings, review, read_count, votes, random, comments, notes, isbn, isbn13, asin, num_pages, format, position, shelves, owned, date_purchased, purchase_location, condition (optional)
	# search[query]: query text to match against member's books (optional)
	# order: a, d (optional)
	# page: 1-N (optional)
	# per_page: 1-200 (optional)
	# key: Developer key (required)
	#
	def list(
		uid:, 
		token:, 
		shelf: 'read', 
		sort: 'date_read', 
		page: 1, 
		per_page: 200, 
		offset: 0
	)
		response = Faraday.get("https://www.goodreads.com/review/list/#{uid}.xml",
			key: token,
			limit: offset,
			sort: 'date_read',
			v: 2,
			page: page,
			per_page: per_page
		)

		results = Hash.from_xml(response.body).with_indifferent_access
		reviews = results["GoodreadsResponse"]["reviews"]

		{ 
			page: page,
			per_page: per_page,
			total: reviews[:total],
			results: Array.wrap(reviews[:review])
		}
	end
end