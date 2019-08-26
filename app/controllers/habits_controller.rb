class HabitsController < ApplicationController
  before_action :authenticate_user!

  def index
    start_date = params[:start_date] || Date.today.beginning_of_month.to_s(:db)
    end_date = params[:start_date] || Date.today.end_of_month.to_s(:db)

    response = airtable_client.fetch_all(
      start_date: start_date,
      end_date: end_date
    )

    json_response(response[:data])
  end

  private

  def airtable_client
    @airtable_client ||= External::AirtableClient.new
  end
end