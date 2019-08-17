class PocketController < ApplicationController
	def index
		client = PocketClient.new
		client.list
	end
end