ActiveRecord::Schema.define(version: 20_170_126_191_401) do
  create_table 'notes', force: :cascade do |t|
    t.integer 'note'
    t.integer 'amount', default: 0, null: false
  end
end
