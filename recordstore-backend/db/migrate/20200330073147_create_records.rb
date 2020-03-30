class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :title
      t.string :year
      t.reference :artist
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
