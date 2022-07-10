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
class CustomField::DateField < CustomField
end
