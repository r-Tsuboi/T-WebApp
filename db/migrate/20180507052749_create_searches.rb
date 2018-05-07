class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end
  end
end
