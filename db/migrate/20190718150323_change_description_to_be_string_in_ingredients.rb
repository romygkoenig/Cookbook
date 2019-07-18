class ChangeDescriptionToBeStringInIngredients < ActiveRecord::Migration[5.2]
  def change
    change_column :ingredients, :description, :string
  end
end
