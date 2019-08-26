class AirtableController < ApplicationController
  before_action :authenticate_user!

  def index
    response = airtable_client.fetch_all(
      start_date: Date.today.beginning_of_month.to_s(:db),
      end_date: Date.today.end_of_month.to_s(:db)
    )

    json_response(response[:data])
  end

  def show
    record = habit_table.find(params[:id])
    render json: record
  end

  private

  def habit_table
    client = Airtable::Client.new("keyfrPeYdlRvZRiXl")
    client.table("appQt6PidlXCkdyTb", "Habits")
  end

  def airtable_client
    @airtable_client ||= External::AirtableClient.new
  end
end