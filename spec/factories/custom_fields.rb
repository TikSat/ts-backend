# == Schema Information
#
# Table name: custom_fields
#
#  id                :uuid             not null, primary key
#  custom_field_type :string
#  desc              :text
#  meta              :jsonb
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
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
