class TableSchema
  AIRTABLE_SCHEMA = {
    schema: {
      "Date" => {
        label: 'Date',
        type: 'date'
      },
      "Deep Work" => {
        label: "Deep Work",
        type: 'number',
      },
      "Exercise" => {
        label: "Exercise",
        type: 'time',
      },
      'How am I feeling?' => {
        label: "Notes",
        type: 'text'
      },
      "Meditation" => {
        label: "Meditation",
        type: 'time',
      },
      "1%" => {
        label: "1%",
        type: 'time',
      },
      "Piano" => {
        label: "Piano",
        type: 'time',
      }
    },
    goals: {
      "1%" => {
        type: :weekly,
        value: 100 # time in minutes
      },
      "Meditation" => {
        type: :weekly,
        value: 100 # time in minutes
      },
      "Piano" => {
        type: :weekly,
        value: 120 # time in minutes
      }
    },
    date_field: 'Date',
    note_field: 'How am I feeling?',
    habit_fields: [
      'Deep Work',
      'Exercise',
      '1%',
      'Meditation',
      'Piano'
    ]
  }

  def initialize(mapping = {})
    @mapping = mapping
  end

  def goals
      @mapping[:goals]
  end

  def schema
    @mapping[:schema]
  end

  def fields
    @mapping[:schema].keys
  end

  def date_field
    @mapping[:date_field]
  end

  def note_field
    @mapping[:note_field]
  end

  def habit_fields
    @mapping[:habit_fields]
  end

  def to_hash
    {
      date_field: date_field,
      goals: goals,
      habit_fields: habit_fields,
      note_field: note_field,
      fields: fields,
      schema: schema
    }
  end
end
