# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
FactoryBot.reload

100.times do
  cat = FactoryBot.create(:category)
  FactoryBot.create_list(:category, 10, parent_id: cat.id)
  fields = []
  fields << FactoryBot.create(:text_field)
  fields << FactoryBot.create(:numeric_field)
  fields << FactoryBot.create(:checkbox_field)
  fields << FactoryBot.create(:date_field)

  cat.custom_fields << fields
end
