class ContentController < ApplicationController
	def index
		dataset = Content.all
		render json: ContentSerializer.new(dataset)
	end
end