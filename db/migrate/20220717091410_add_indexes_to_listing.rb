class AddIndexesToListing < ActiveRecord::Migration[7.0]
  def up
    sql = <<~SQL
      create index if not exists idx_field_values on listings using btree (((field_values->>'field_id')::uuid));
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def down
    sql <<~SQL
      drop index if exists idx_field_values
    SQL

    ActiveRecord::Base.connection.execute(sql)
  end
end
