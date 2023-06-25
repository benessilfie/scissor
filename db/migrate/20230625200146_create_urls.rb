class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_code, unique: true, index: true
      t.string :short_url
      t.integer :count, default: 0
      t.belongs_to :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
