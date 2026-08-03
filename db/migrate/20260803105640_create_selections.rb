class CreateSelections < ActiveRecord::Migration[8.1]
  def change
    create_table :selections do |t|
      t.references :community, null: false, foreign_key: true
      t.references :content,   null: false, foreign_key: true

      t.timestamps
    end

    add_index :selections, [ :community_id, :content_id ], unique: true
  end
end
