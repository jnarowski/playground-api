class AirtableController < ApplicationController
  # https://github.com/Airtable/airtable-ruby 
  def index
    records = habit_table.records(
      fields: ["Date", "Day Type"],
      sort: ["Date", :asc], 
      limit: 100
    )
    render json: records
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
end