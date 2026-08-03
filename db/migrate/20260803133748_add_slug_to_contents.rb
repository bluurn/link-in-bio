class AddSlugToContents < ActiveRecord::Migration[8.1]
  def change
    add_column :contents, :slug, :string, null: false, default: ""
    add_index :contents, :slug, unique: true
  end
end
