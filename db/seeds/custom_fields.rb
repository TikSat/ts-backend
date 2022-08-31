FIELDS = [
  {
    name: 'Rooms',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Floor',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Heating',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'Net Square',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Living Square',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Details',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'Year',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Model',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'Fuel',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'Brand',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'KM',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Body Type',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'Engine Power',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Wheels',
    custom_field_type: 'CustomField::TextField'
  },
  {
    name: 'Doors',
    custom_field_type: 'CustomField::NumericField'
  },
  {
    name: 'Color',
    custom_field_type: 'CustomField::TextField'
  }
].freeze

CustomField.upsert_all(FIELDS)
