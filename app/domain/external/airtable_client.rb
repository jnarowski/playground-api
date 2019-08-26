class External::AirtableClient
  # https://api.airtable.com/v0/appQt6PidlXCkdyTb/Habits?fields%5B%5D=Date&fields%5B%5D=Day%20Type&limit=100&sortDirection=asc&sortField=Date
  API_KEY = 'keyfrPeYdlRvZRiXl'
  TABLE_KEY = 'appQt6PidlXCkdyTb'

  def fetch_all(params = {})
    habit_table = TableSchema.new(TableSchema::AIRTABLE_SCHEMA)

    response = Faraday.get("https://api.airtable.com/v0/appQt6PidlXCkdyTb/Habits") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = 'Bearer keyfrPeYdlRvZRiXl'
      req.params = {
        fields: habit_table.fields,
        filterByFormula: "AND({DATE} >= '#{params[:start_date]}', {DATE} <= '#{params[:end_date]}')"
      }
    end

    results = map_records(response, habit_table)

    {
      response: response,
      data: {
        meta: habit_table.to_hash,
        results: results
      }
    }
  end

  private

  def map_records(response, table_schema)
    body = JSON.parse(response.body).with_indifferent_access

    results = body["records"].map do |item|
      fields = item["fields"].with_indifferent_access

      habit_fields = item["fields"].slice(*table_schema.habit_fields)
      fields["all_empty"] = habit_fields.values.blank?
      fields["logged"] = habit_fields.values.present?

      fields
    end

    results.sort_by{|s| s["Date"] }
  end
end