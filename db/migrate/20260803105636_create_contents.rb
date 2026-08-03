class CreateContents < ActiveRecord::Migration[8.1]
  def change
    create_table :contents do |t|
      t.string  :creator,         null: false
      t.string  :title,           null: false
      t.integer :kind,            null: false, default: 0
      t.text    :description
      t.decimal :price,           precision: 8, scale: 2, null: false, default: 0
      t.string  :url,             null: false
      t.string  :cover_image_url

      t.timestamps
    end
  end
end
