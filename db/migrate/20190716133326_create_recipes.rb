class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :ingredients
      t.text :description
      t.string :image
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end