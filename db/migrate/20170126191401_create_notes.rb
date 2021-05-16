class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.column :note, :integer, uniqueness: true, min: 1
      t.column :amount, :integer, min: 0, null: false, default: 0
    end
  end
end
