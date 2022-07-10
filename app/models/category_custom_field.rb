# == Schema Information
#
# Table name: category_custom_fields
#
#  id              :uuid             not null, primary key
#  category_id     :uuid
#  custom_field_id :uuid
#
# Indexes
#
#  index_category_custom_fields_on_category_id      (category_id)
#  index_category_custom_fields_on_custom_field_id  (custom_field_id)
#
class CategoryCustomField < ApplicationRecord
  belongs_to :category
  belongs_to :custom_field
end
