FactoryBot.define do
  factory :custom_field do
    name { Faker::Finance.ticker }
    desc { Faker::Finance.vat_number }

    factory :text_field, parent: :custom_field do
      custom_field_type { 'CustomField::TextField' }
    end

    factory :numeric_field, parent: :custom_field do
      custom_field_type { 'CustomField::NumericField' }
    end

    factory :checkbox_field, parent: :custom_field do
      custom_field_type { 'CustomField::CheckboxField' }
    end

    factory :date_field, parent: :custom_field do
      custom_field_type { 'CustomField::DateField' }
    end
  end
end
