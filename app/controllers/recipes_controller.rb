class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @ingredients = []
    params[:recipe][:ingredients_attributes].values.each do |i|
      @ingredients << Ingredient.new(description: i[:description], recipe: @recipe)
    end
    @recipe.ingredients = @ingredients
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Your recipe was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipe_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, :category, ingredientss_attributes: [:id, :description])
  end
end
