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
class CustomField < ApplicationRecord
  self.inheritance_column = 'custom_field_type'
  has_many :category_custom_fields
  has_many :categories, through: :category_custom_fields
end
